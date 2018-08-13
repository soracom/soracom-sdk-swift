//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getLogs(
        
        resourceType: ResourceType? = nil,
        resourceId: String? = nil,
        service: Service? = nil,
        from: Int? = nil,
        to: Int? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[LogEntry]>? = nil
    ) ->   Request<[LogEntry]> {

        let path  = "/logs"

        let requestObject = Request<[LogEntry]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "resourceType": resourceType,
            "resourceId": resourceId,
            "service": service,
            "from": from,
            "to": to,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
