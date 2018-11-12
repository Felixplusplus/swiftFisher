import Foundation
import Rainbow


let launchpath = FileManager.default.currentDirectoryPath
print("===================================================================")
print("FX: script launch from \(launchpath)".yellow.underline)
print("===================================================================")

let gitStatusOption = FXCommandOption(name: "-g", usage: "to print all git status in your folder") { (s) in
    
    FileManager.default.changeCurrentDirectoryPath(launchpath)
    
    let gitHappendPaths = FXDirectory.fx_sub_direcories(in: FileManager.default.currentDirectoryPath).filter { (p) -> Bool in
        return FXDirectory.isGitPath(path: p)
        }.filter { (p) -> Bool in
            return FXDirectory.gitHappend(in: p)
    }
    if gitHappendPaths.count>0 {
        print("FX: In your paths ,there are some path git changes in blow".cyan)
        gitHappendPaths.forEach { (p) in
            print(p.lightBlue)
        }
    }else {
        print("There is no git change in this children paths".cyan)
    }
}

let gitBranchOption = FXCommandOption(name: "-gb", usage: "to print all git branch in your folder") { (s) in
    
    FileManager.default.changeCurrentDirectoryPath(launchpath)
    
    let allGitPath = FXDirectory.fx_sub_direcories(in: FileManager.default.currentDirectoryPath).filter { (p) -> Bool in
        return FXDirectory.isGitPath(path: p)
    }
    allGitPath.forEach { (p) in
        let name:String = String(p.split(separator: "/").last ?? "NoNameFolder")
        FileManager.default.changeCurrentDirectoryPath(p)
        let bc = FXExecution.executeString("git","rev-parse","--abbrev-ref","HEAD")?.white ?? "no branch".green
        print(name.red+" : "+bc)
    }
    
}

let gitOpenOption = FXCommandOption(name: "-go", usage: "to open git in safari") { (s) in
    
    FileManager.default.changeCurrentDirectoryPath(launchpath)
    
    guard FXDirectory.isGitPath(path: launchpath) else {return}
    guard let urlHole = FXExecution.executeString("git","remote","-v") else {return}
    guard let url = urlHole.split(separator: "@")[1].split(separator: " ").first else {return}
    guard let branchHole = FXExecution.executeString("git","branch") else {return}
    guard let branch =  branchHole.split(separator: "\n").filter({ (s) -> Bool in
        return s.contains("*")
    }).first?.split(separator: " ")[1]else {return}
    
    let uu = url[url.startIndex..<url.index(url.endIndex, offsetBy: -4)]+"/tree/"+branch
    guard let uuRange = uu.range(of: ":") else {return}
    let uuu = uu.prefix(upTo: uuRange.lowerBound)+"/"+uu.suffix(from: uuRange.upperBound)
    
    let uuuu = "http://" + uuu
    
    FXExecution.execute("open",uuuu, handle: { (s) in
        
    })
}


let cmd = FXCommandLine()
cmd.addOptions(os: [gitStatusOption,gitBranchOption,gitOpenOption])
cmd.parseAll(args: CommandLine.arguments)

//if args.contains("g") {
//
//    let gitHappendPaths = FXDirectory.fx_sub_direcories(in: FileManager.default.currentDirectoryPath).filter { (p) -> Bool in
//        return FXDirectory.isGitPath(path: p)
//        }.filter { (p) -> Bool in
//            return FXDirectory.gitHappend(in: p)
//    }
//    if gitHappendPaths.count>0 {
//        print("FX: In your paths ,there are some path git changes in blow".cyan)
//        gitHappendPaths.forEach { (p) in
//            print(p.lightBlue)
//        }
//    }else {
//        print("There is no git change in this children paths".cyan)
//    }
//}
//
//if args.contains("gb") {
//
//    let allGitPath = FXDirectory.fx_sub_direcories(in: FileManager.default.currentDirectoryPath).filter { (p) -> Bool in
//        return FXDirectory.isGitPath(path: p)
//    }
//    allGitPath.forEach { (p) in
//        print(p.red)
//        FileManager.default.changeCurrentDirectoryPath(p)
//        print(FXExecution.executeString("git","branch")?.white ?? "no branch".green)
//    }
//}

exit(EX_OK)



