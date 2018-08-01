extension Request where T == [Subscriber] {

    public class func listSubscribers(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        statusFilter: String? = nil,
        speedClassFilter: String? = nil,
        serialNumberFilter: String? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[Subscriber]>? = nil
    ) ->   Request<[Subscriber]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listSubscribers(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, statusFilter: statusFilter, speedClassFilter: speedClassFilter, serialNumberFilter: serialNumberFilter, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listSubscribers()) is not sufficient):

        return req
    }
    
        /// List registered subcribers (SIMs). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/listSubscribers))
    
//    public class func listSubscribers(tagName: String?             = nil,
//                                     tagValue: String?             = nil,
//                            tagValueMatchMode: TagValueMatchMode?  = nil,
//                                 statusFilter: [SubscriberStatus]? = nil,
//                             speedClassFilter: [SpeedClass]?       = nil,
//                                        limit: Int?                = nil,
//                             lastEvaluatedKey: String?             = nil,
//                              responseHandler: ResponseHandler<[Subscriber]>? = nil
//    ) -> Request<[Subscriber]> {
//
//        let query  = makeQueryDictionary(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, statusFilter: statusFilter, speedClassFilter: speedClassFilter, limit: limit, lastEvaluatedKey: lastEvaluatedKey)
//
//        let req    = Request<[Subscriber]>.init("/subscribers", responseHandler: responseHandler)
//        req.query  = query
//        req.method = .get
//        return req
//    }
    
    

}
