//
//  FXCommandLine.swift
//  Rainbow
//
//  Created by Felix on 2018/6/14.
//

import Foundation

typealias FX_String_handle = (String?)->Void

struct FXCommandOption {
    let name:String
    let usage:String
    let handle:FX_String_handle?
}

class FXCommandLine {
    var options:[FXCommandOption]
    init() {
        options = Array()
    }
    
    func addOption(option:FXCommandOption) -> Void {
        options.append(option)
    }
    func addOptions(os:[FXCommandOption]) -> Void {
        options.append(contentsOf: os)
    }
    func parseAll(args:[String]) -> Void {
        var s_args = args
        s_args.removeFirst()
        s_args.append("-")
        var msg:String = ""
        if s_args.count<=1 {
            printUsage()
            return
        }
        var count = 0
        s_args.forEach { (s) in
            if msg.count>0 && msg.isFXCommandOptionTitle(){
                if s.isFXCommandOptionTitle(){
                    if parseOption(title: msg, value: nil) {
                        count += 1
                    }
                }else {
                    if parseOption(title: msg, value: s) {
                        count += 1
                    }
                }
            }
            msg = s
        }
        if count < 1 {
            printUsage()
        }
    }
    
    func printUsage() {
        print("Usage:")
        options.forEach { (op) in
            print(op.name+" "+op.usage)
        }
    }
    
    func parseOption(title:String ,value:String?) -> Bool {
        guard let op = options.filter({ (o) -> Bool in
            return o.name == title
        }).first else { return false}
        op.handle?(value)
        return true
    }
}

extension String {
    func isFXCommandOptionTitle() -> Bool {
        return self.hasPrefix("-")
    }
}
