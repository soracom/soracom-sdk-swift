// Request+SubscriberAPI.swift Created by mason on 2016-03-20. Copyright © 2016 Soracom, Inc. All rights reserved.

extension Request where T == [Subscriber] {
    
    /**
     List registered subcribers (SIMs). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/listSubscribers))
     */
    public class func listSubscribers(
        
        tagName:           String?                        = nil,
        tagValue:          String?                        = nil,
        tagValueMatchMode: TagValueMatchMode?             = nil,
        statusFilter:      [SubscriberStatus]?            = nil,
        speedClassFilter:  [SpeedClass]?                  = nil,
        limit:             Int?                           = nil,
        lastEvaluatedKey:  String?                        = nil,
        responseHandler:   ResponseHandler<[Subscriber]>? = nil
        
        ) -> Request<[Subscriber]> {
        
        return listSubscribers(
            tagName:           tagName,
            tagValue:          tagValue,
            tagValueMatchMode: tagValueMatchMode,
            statusFilter:      SubscriberStatus.queryValue(statusFilter),
            speedClassFilter:  SpeedClass.queryValue(speedClassFilter),
            limit:             limit,
            lastEvaluatedKey:  lastEvaluatedKey,
            responseHandler:   responseHandler
        )
    }
    
}


extension Request where T == Subscriber {
    
    /// Register a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/registerSubscriber))
    
    public class func registerSubscriber(_ imsi: String, registrationSecret: String, responseHandler: ResponseHandler<Subscriber>? = nil) -> Request<Subscriber> {
        
        let req = Request<Subscriber>.init("/subscribers/\(imsi)/register", responseHandler: responseHandler)
        
        req.messageBody = RegisterSubscribersRequest(registrationSecret: registrationSecret).toData()
        
        // FIXME: groupId and tags
        
        // FIXME: file bug against API docs, which say this it what we should expect: req.expectedHTTPStatus = 201
        
        req.expectedHTTPStatus = 200
        
        return req
    }
    
    
    /// Get the properties of a single subscriber (a SIM). ([API Documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/getSubscriber))
    
    public class func getSubscriber(_ imsi: String,responseHandler: ResponseHandler<Subscriber>? = nil) -> Request<Subscriber> {

        let req = Request<Subscriber>.init("/subscribers/\(imsi)", responseHandler: responseHandler)
        req.method = .get
        return req
    }
    
    
    /// Update speed class of a subscriber (a SIM). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/updateSpeedClass))
    
    public class func updateSpeedClass(_ imsi: String, speedClass: UpdateSpeedClassRequest.SpeedClass, responseHandler: ResponseHandler<Subscriber>? = nil) -> Request<Subscriber> {
        
        // FIXME: the _UpdateSpeedClassRequest.SpeedClass thing there is gross... how to handle?

        let req = Request<Subscriber>.init("/subscribers/\(imsi)/update_speed_class", responseHandler: responseHandler)
        
        req.messageBody = UpdateSpeedClassRequest(speedClass: speedClass).toData()
        req.expectedHTTPStatus = 200
        return req
    }
    
    
    /// Convenience method to set IMEI lock from a simple string IMEI... FIXME: test whether Xcode will offer the convenience form in autocomplete automatically, if we make the SetImeiLockRequest expressible by string literal. If so, then this wouldn't be worth having...
    
    public class func setImeiLock(imsi: String, imei: String? = nil, responseHandler: ResponseHandler<Subscriber>? = nil) -> Request<Subscriber> {
        
        let req = Request<Subscriber>.init("/subscribers/\(imsi)/set_imei_lock", responseHandler: responseHandler)
        
        req.method = .post
        
        req.messageBody = SetImeiLockRequest(imei: imei).toData()
        
        req.expectedHTTPStatus = 200
        return req
    }
    
    
}
