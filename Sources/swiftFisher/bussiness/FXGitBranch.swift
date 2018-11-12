//
//  FXGitBranch.swift
//  swiftFisher
//
//  Created by Felix on 2018/11/12.
//

import Foundation

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
