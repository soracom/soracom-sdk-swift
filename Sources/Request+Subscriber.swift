// Request+SubscriberAPI.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.

extension Request {
     
    /// Register a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/registerSubscriber))
    
    public class func registerSubscriber(imsi: String, registrationSecret: String) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/register")
        
        req.requestPayload = [.registrationSecret: registrationSecret]
        
        // FIXME: groupId and tags
        
        // FIXME: file bug against API docs, which say this it what we should expect: req.expectedHTTPStatus = 201
        
        req.expectedHTTPStatus = 200
        
        return req
    }
    
}
