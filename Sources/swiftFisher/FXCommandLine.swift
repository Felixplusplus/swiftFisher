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
        s_args.forEach { (s) in
            if msg.count>0 && msg.isFXCommandOptionTitle(){
                if s.isFXCommandOptionTitle(){
                    parseOption(title: msg, value: nil)
                }else {
                    parseOption(title: msg, value: s)
                }
            }
            msg = s
        }
    }
    
    func parseOption(title:String ,value:String?) -> Void {
        guard let op = options.filter({ (o) -> Bool in
            return o.name == title
        }).first else { return  }
        op.handle?(value)
    }
}

extension String {
    func isFXCommandOptionTitle() -> Bool {
        return self.hasPrefix("-")
    }
}
