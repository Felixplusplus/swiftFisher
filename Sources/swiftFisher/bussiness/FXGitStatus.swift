//
//  FXGitStatus.swift
//  swiftFisher
//
//  Created by Felix on 2018/11/12.
//

import Foundation

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
