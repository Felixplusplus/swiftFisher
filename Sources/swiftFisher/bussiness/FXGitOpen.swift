//
//  FXGitOpen.swift
//  swiftFisher
//
//  Created by Felix on 2018/11/12.
//

import Foundation

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
