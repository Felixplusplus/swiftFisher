//
//  FXDirectory.swift
//  swiftFisher
//
//  Created by Felix on 2018/5/16.
//

import Foundation

typealias FX_Bool_handle = (Bool)->Void

class FXDirectory {
    
    class func fx_sub_direcories(in path:String) -> Array<String> {
        var paths:Array<String> = []
        var folders:Array<String> = []
        do {
            try folders.append(contentsOf: FileManager.default.contentsOfDirectory(atPath: path))
        }catch {
            return paths;
        }
        folders.forEach { (p) in
            paths.append(path+"/"+p)
        }
        return paths
    }
    
    class func isGitPath(path:String) -> Bool {
        return FileManager.default.fileExists(atPath: path+"/.git/")
    }
    
    class func fx_git_status(in path:String) -> Void {
        if FileManager.default.changeCurrentDirectoryPath(path) {
            _ = FXExecution.execute("git","status") { (outPutString) in
                if !outPutString.contains("nothing to commit, working tree clean") {
                    print(outPutString)
                }else {
                    print("greate,, it's  nothing".green)
                }
            }
        }
    }
    
    class func gitHappend(in path:String) -> Bool {
        if FileManager.default.changeCurrentDirectoryPath(path) {
            if let s = FXExecution.executeString("git","status") {
                if s.contains("nothing to commit, working tree clean") {
                    return false;
                }
                return true;
            }
            return false;
        }
        return false
    }
}
