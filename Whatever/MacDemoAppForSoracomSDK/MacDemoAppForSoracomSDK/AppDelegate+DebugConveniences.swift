// AppDelegate+DebugConveniences.swift Created by mason on 2016-05-14. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

extension AppDelegate {

    
    @IBAction func debug1(sender: AnyObject) {
        log("🐞 DEBUG 1: This will print the operation queue. Edit debug1() in AppDelegate.swift to change what this does.")
        log("\(queue.operations)")
    }
    
    
    @IBAction func debug2(sender: AnyObject) {
        log("🐜 DEBUG 2: This doesn't do anything except log this message. Edit debug2() in AppDelegate.swift to change what this does.")
    }
    
    
    @IBAction func debug3(sender: AnyObject) {
        
        log("🐛 DEBUG 3: This doesn't do anything except log this message. Edit debug3() in AppDelegate.swift to change what this does.")
    }
    
}
