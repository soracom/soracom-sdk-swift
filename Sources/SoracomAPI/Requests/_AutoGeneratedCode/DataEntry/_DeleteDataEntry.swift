//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteDataEntry(
        
        resourceType: ResourceType,
        resourceId: String,
        time: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/data/\(resourceType.encode())/\(resourceId)/{time}"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete

        requestObject.query = makeQueryDictionary([
            "time": time
        ])

        return requestObject
    }

}
