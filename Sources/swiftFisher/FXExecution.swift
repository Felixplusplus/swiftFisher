//
//  FXExecution.swift
//  swiftFisher
//
//  Created by Felix on 2018/5/16.
//

import Foundation

typealias FX_string_handle = (String)->Void

class FXExecution {
    
    class func execute(_ args:String..., handle:FX_string_handle?) -> Int {
        
        let task = Process()
        
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        
        // Get the data
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let outPutString = String(data: data, encoding: String.Encoding.utf8)
        if let ss = outPutString {
            handle?(ss)
        }
        return Int(task.terminationStatus)
    }
    
    class func executeString(_ args:String...) -> String? {
        
        let task = Process()
        
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        let pipe = Pipe()
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        
        
        // Get the data
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let outPutString = String(data: data, encoding: String.Encoding.utf8)
        
        return outPutString;
    }
}
