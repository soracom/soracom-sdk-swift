//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listSubscribers(
        
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

        let path = "/subscribers" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<[Subscriber]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "tagName": tagName as Any,
            "tagValue": tagValue as Any,
            "tagValueMatchMode": tagValueMatchMode as Any,
            "statusFilter": statusFilter as Any,
            "speedClassFilter": speedClassFilter as Any,
            "serialNumberFilter": serialNumberFilter as Any,
            "limit": limit as Any,
            "lastEvaluatedKey": lastEvaluatedKey as Any
        ])

        return requestObject
    }

}
