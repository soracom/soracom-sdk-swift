// Request+SubscriberAPI.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.


extension Request {
    
    /// List registered subcribers (SIMs). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/listSubscribers))
    
    public class func listSubscribers(tagName: String?             = nil,
                                     tagValue: String?             = nil,
                            tagValueMatchMode: TagValueMatchMode?  = nil,
                                 statusFilter: [SubscriberStatus]? = nil,
                             speedClassFilter: [SpeedClass]?       = nil,
                                        limit: Int?                = nil,
                             lastEvaluatedKey: String?             = nil,
                              responseHandler: ResponseHandler?    = nil
    ) -> Request {
        

        let query  = makeQueryDictionary(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, statusFilter: statusFilter, speedClassFilter: speedClassFilter, limit: limit, lastEvaluatedKey: lastEvaluatedKey)
        
        let req    = self.init("/subscribers", responseHandler: responseHandler)
        req.query  = query
        req.method = .get
        return req
    }
    
    
    /// Register a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/registerSubscriber))
    
    public class func registerSubscriber(_ imsi: String, registrationSecret: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/register", responseHandler: responseHandler)
        
        req.payload = [.registrationSecret: registrationSecret]
        
        // FIXME: groupId and tags
        
        // FIXME: file bug against API docs, which say this it what we should expect: req.expectedHTTPStatus = 201
        
        req.expectedHTTPStatus = 200
        
        return req
    }
    
    
    /// Get the properties of a single subscriber (a SIM). ([API Documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/getSubscriber))
    
    public class func getSubscriber(_ imsi: String,responseHandler: ResponseHandler? = nil) -> Request {

        let req = self.init("/subscribers/\(imsi)", responseHandler: responseHandler)
        req.method = .get
        return req
    }
    
    
    /// Update speed class of a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/updateSpeedClass))
    
    public class func updateSpeedClass(_ imsi: String, speedClass: SpeedClass, responseHandler: ResponseHandler? = nil) -> Request {

        let req = self.init("/subscribers/\(imsi)/update_speed_class", responseHandler: responseHandler)
        
        req.payload = [.speedClass: speedClass.rawValue]
        req.expectedHTTPStatus = 200
        return req
    }
    
    
    public class func setImeiLock(imsi: String, imei: String? = nil, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/set_imei_lock", responseHandler: responseHandler)
        
        req.method = .post
        
        if let imei = imei {
            req.payload = [.imei: imei]
        }
        req.expectedHTTPStatus = 200
        return req
    }
    
    public class func unsetImeiLock(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/unset_imei_lock", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    

    
}
