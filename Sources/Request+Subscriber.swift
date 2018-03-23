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
    
    /// Deletes session for the specified subscriber.
    public class func deleteSession(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/delete_session", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Activates status of specified subscriber.
    public class func activate(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/activate", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Deactivates specified subscriber.
    public class func deactivate(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/deactivate", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Terminates the specified subscriber
    public class func terminate(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/terminate", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Suspend the specified subscriber
    public class func suspend(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/suspend", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Set the specified subscriber to standby mode.
    public class func setToStandby(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/set_to_standby", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    public class func enableTermination(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/enable_termination", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    public class func disableTermination(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/disable_termination", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Update/Set Expiry time [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/setExpiryTime)
    public class func setExpiryTime(imsi: String, expiryTime: Int, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/set_expiry_time", responseHandler: responseHandler)
        
        req.method = .post
        req.payload = [.expiryTime: expiryTime]
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Delete/Unset expiry time ( [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/unsetExpiryTime) )
    public class func deleteExpiryTime(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/unset_expiry_time", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 204
        return req
    }
    
    /// Set Group [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/setGroup)
    public class func setGroup(imsi: String, groupId: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/set_group", responseHandler: responseHandler)
        
        req.method = .post
        req.payload = [.groupId: groupId]
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Unset group removes the subscriber from group
    public class func unsetGroup(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/unset_group", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// List Session Events [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/listSessionEvents)
    public class func listSessionEvents(imsi: String, from: Int?, to:Int?, limit: Int?, lastEvaluatedKey: String?, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/events/sessions", responseHandler: responseHandler)
        
        let query  = makeQueryDictionary(from: from, to: to, limit: limit, lastEvaluatedKey: lastEvaluatedKey)
        
        req.method = .get
        req.query = query
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Bulk Insert or Update Subscriber Tags. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/putSubscriberTags)
    public class func putTags(imsi: String, tags: [String:String], responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/tags", responseHandler: responseHandler)
        
        var tagList: TagList = []
        
        for (k,v) in tags {
            let tag = Tag(tagName: k, tagValue: v)
            tagList.append(tag)
        }
        
        req.payload = Payload(tagList: tagList)
        
        req.method = .put
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Delete a subscriber tag [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/deleteSubscriberTag)
    public class func deleteTag(imsi: String, tagName: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/tags/\(tagName)", responseHandler: responseHandler)
        
        req.method = .delete
        req.expectedHTTPStatus = 204
        return req
    }
    
    /// Sends the subscriber's inter-operator control transfer token to the control destination operator. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/issueSubscriberTransferToken)
    public class func issueTransferToken(destinationOperatorEmail: String, destinationOperatorId: String, imsis: [String], responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/transfer_token/issue", responseHandler: responseHandler)
        
        req.payload = [.transferDestinationOperatorEmail: destinationOperatorId,
                       .transferDestinationOperatorId: destinationOperatorId,
                       .transferImsi: imsis]
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Verifies the subscriber's control transfer token, and executes the transfer. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/verifySubscriberTransferToken)
    public class func verifyTransferToken(token: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/transfer_token/issue", responseHandler: responseHandler)
        
        req.payload = [.token: token]
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Deletes the subscriber's inter-operator control transfer token, and cancels the control transfer. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/deleteSubscriberTransferToken)
    public class func deleteTransferToken(token: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/transfer_token/\(token)", responseHandler: responseHandler)
        
        req.method = .delete
        req.expectedHTTPStatus = 204
        return req
    }
    
    /// Get data sent from a subscriber. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/getDataFromSubscriber)
    public class func getData(imsi: String, from: Int?, to:Int?, sort:SortDirection?, limit: Int?, lastEvaluatedKey: String?, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/data", responseHandler: responseHandler)
        
        let query  = makeQueryDictionary(from: from, to: to, sort: sort, limit: limit, lastEvaluatedKey: lastEvaluatedKey)
        
        req.method = .get
        req.query = query
        req.expectedHTTPStatus = 200
        return req
    }
    
    
    /// Send SMS to Subscriber [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/sendSms)
    public class func sendSMS(imsi: String, encodingType: Int, payload: String,responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/send_sms", responseHandler: responseHandler)
        
        // FIXME: make the encoding type an enum
        req.payload = [.encodingType: encodingType,
                       .payload: payload]
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }
    
    /// Triggers Subscriber to report SIM local info. [APIDocs](https://dev.soracom.io/en/docs/api/#!/Subscriber/reportLocalInfo)
    public class func reportLocalInfo(imsi: String, responseHandler: ResponseHandler? = nil) -> Request {
        
        let req = self.init("/subscribers/\(imsi)/report_local_info", responseHandler: responseHandler)
        
        req.method = .post
        req.expectedHTTPStatus = 200
        return req
    }

    
}
