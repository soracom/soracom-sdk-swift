// Request+SubscriberAPI.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.

extension Request {
    
    /// List registered subcribers (SIMs). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/listSubscribers))
    
    public class func listSubscribers(tagName
                                      tagName: String?             = nil,
                                     tagValue: String?             = nil,
                            tagValueMatchMode: TagValueMatchMode?  = nil,
                                 statusFilter: [SubscriberStatus]? = nil,
                             speedClassFilter: [SpeedClass]?       = nil,
                                        limit: Int?                = nil,
                             lastEvaluatedKey: String?             = nil,
                              responseHandler: ResponseHandler?    = nil
    ) -> Request {
        
        var query: [String:String] = [:]
        
        if let name = tagName, value = tagValue, mode = tagValueMatchMode {
            
            query["tag_name"]             = name
            query["tag_value"]            = value
            query["tag_value_match_mode"] = mode.rawValue
        }
        
        if let statusFilter = statusFilter {
            if statusFilter.count > 0 {
                let strings = statusFilter.map {e in e.rawValue}
                query["status_filter"] = strings.joinWithSeparator("|")
            }
        }
        
        if let speedClassFilter = speedClassFilter {
            if speedClassFilter.count > 0 {
                let strings = speedClassFilter.map {e in e.rawValue}
                query["speed_class_filter"] = strings.joinWithSeparator("|")
            }
        }
        
        if let limit = limit {
            query["limit"] = String(limit)
        }
        
        
        if let lastEvaluatedKey = lastEvaluatedKey {
            query["last_evaluated_key"] = lastEvaluatedKey
        }
        
        // FIXME: It is probably worth making a generic query object if we need to do the above kind of work in more than 2-3 places. 
        
        let req    = self.init("/subscribers", responseHandler: responseHandler)
        req.query  = query
        req.method = .GET
        return req
    }
    
    
    /// Register a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/registerSubscriber))
    
    public class func registerSubscriber(imsi: String, registrationSecret: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/register", responseHandler: responseHandler)
        
        req.payload = [.registrationSecret: registrationSecret]
        
        // FIXME: groupId and tags
        
        // FIXME: file bug against API docs, which say this it what we should expect: req.expectedHTTPStatus = 201
        
        req.expectedHTTPStatus = 200
        
        return req
    }
    
    
    /// Get the properties of a single subscriber (a SIM). ([API Documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/getSubscriber))
    
    public class func getSubscriber(imsi: String,responseHandler: ResponseHandler? = nil) -> Request {

        let req = self.init("/subscribers/\(imsi)", responseHandler: responseHandler)
        req.method = .GET
        return req
    }
    
    
    /// Update speed class of a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/updateSpeedClass))
    
    public class func updateSpeedClass(imsi: String, speedClass: SpeedClass, responseHandler: ResponseHandler? = nil) -> Request {

        let req = self.init("/subscribers/\(imsi)/update_speed_class", responseHandler: responseHandler)
        
        req.payload = [.speedClass: speedClass.rawValue]
        req.expectedHTTPStatus = 200
        return req
    }
    
}
