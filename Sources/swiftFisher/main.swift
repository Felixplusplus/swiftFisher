import Foundation
import CommandLineKit
import Rainbow

//print("Red text".red)
//print("Blue background".onBlue)
//print("Light green text on white background".lightGreen.onWhite)
//
//print("Underline".underline)
//print("Cyan with bold and blinking".cyan.bold.blink)
//
//print("Plain text".red.onYellow.bold.clearColor.clearBackgroundColor.clearStyles)

//let cli = CommandLineKit.CommandLine()
//
//let filePath = StringOption(shortFlag: "s", longFlag: "stringsPath", required: false,
//                            helpMessage: "Path to the localized.strings folder path")
//
//let gitsPath = StringOption(shortFlag: "g", longFlag: "git folders path", required: false,
//                            helpMessage: "Path to the gits to find out what happend")
//
//
//cli.addOptions([filePath,gitsPath])
//
//do {
//    try cli.parse()
//} catch {
//    cli.printUsage(error)
//    exit(EX_USAGE)
//}

/// 查找string文件list
///
/// - Parameters:
///   - fm: filemanager
///   - fileFolderPath: folder
/// - Returns: string array
//func searchStringsFile(with fm:FileManager,fileFolderPath:URL) ->  Array<String> {
//
//    var sf:Array<String> = []
//    if let e:FileManager.DirectoryEnumerator = fm.enumerator(at: fileFolderPath,
//                                                             includingPropertiesForKeys: nil,
//                                                             options: .skipsHiddenFiles,
//                                                             errorHandler: nil) {
//        e.forEach { (p) in
//            if let url = p as? URL {
//                if url.path.components(separatedBy: ["."]).last == "strings" {
//                    let u = url.path
//                    print("FileURL: ".cyan+u.yellow.blink)
//                    sf.append(u)
//                }
//            }
//        }
//    }
//    return sf
//}


let fm = FileManager.default

print("FX: script launch from \(fm.currentDirectoryPath)".yellow.underline)
let args = CommandLine.arguments

if args.contains("g") {
    
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

//print(CommandLine.arguments)

//if let p = filePath.value {
//    print("Folder path is \(p)")
//    print("Strings file path is ".green)
//    stringsList.append(contentsOf: searchStringsFile(with: fm, fileFolderPath: URL(fileURLWithPath: p)))
//
//}

//if let g = gitsPath.value {
//    print("Begin to find out what Git happend in \(g)".green)
//
//    FXDirectory.fx_all_git_status(in: g)
//}

exit(EX_OK)



