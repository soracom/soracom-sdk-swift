// NSOperationQueue+Request.swift Created by mason on 2016-04-23. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation


extension NSOperationQueue {
    
    /// A convenience to avoid writing boilerplate code when adding sequential requests to an operation queue.
    
    func addRequest(request: Request, completionHandler: ResponseHandler? = nil) {
        
        self.addOperation(APIOperation(request, completionHandler: completionHandler))
    }    
    
}
