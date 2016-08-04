// RequestQueue.swift Created by mason on 2016-05-08. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Implements a singleton operation queue used that may be used to run all requests in a client app, if that's convenient.
///
/// It is not necessary to use this; a client app is free to define its own operation queue(s) as needed.


class RequestQueue {
    
    /// Returns a single shared NSOperationQueue instance, that may be used to run all requests, if that's convenient.
    
    static let sharedQueue: OperationQueue = {
        let q = OperationQueue()
        q.maxConcurrentOperationCount = 1
        return q
    }()
    
}
