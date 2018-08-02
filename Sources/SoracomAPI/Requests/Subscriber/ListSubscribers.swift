extension Request where T == [Subscriber] {

    /**
     List registered subcribers (SIMs). ([API documentation](https://dev.soracom.io/jp/docs/api/#!/Subscriber/listSubscribers))
     */
    public class func listSubscribers(

        tagName:            String?                        = nil,
        tagValue:           String?                        = nil,
        tagValueMatchMode:  TagValueMatchMode?             = nil,
        statusFilter:       String?                        = nil,
        speedClassFilter:   String?                        = nil,
        serialNumberFilter: String?                        = nil,
        limit:              Int?                           = nil,
        lastEvaluatedKey:   String?                        = nil,
        responseHandler:    ResponseHandler<[Subscriber]>? = nil

    ) ->   Request<[Subscriber]> {

        // Call the auto-generated implmentation, created from the API spec:
        let req = _listSubscribers(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, statusFilter: statusFilter, speedClassFilter: speedClassFilter, serialNumberFilter: serialNumberFilter, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        return req
    }

    
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
