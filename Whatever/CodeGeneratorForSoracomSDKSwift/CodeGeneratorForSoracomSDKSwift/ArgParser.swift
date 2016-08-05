// ArgParser.swift Created by mason on 2016-08-05. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation


class ArgParser {
    
    /// Provides an **extremely** brain-dead form of command-line arg parsing: just turns "a b c d" into ["a": "b", "c": "d"]

    class func parse(_ args: [String] = [], skipFirstArg: Bool = true) -> [String:String] {
        
        var opts: [String:String] = [:]
        
        let start = skipFirstArg ? 1 : 0
        
        for i in stride(from: start, to: args.count, by:2) {
            let j = i + 1
            if j < args.count {
                opts[args[i]] = args[j]
            }
        }
        return opts
    }

}
