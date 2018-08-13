//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteConfigurationParameter(
        
        groupId: String,
        namespace: Namespace,
        name: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/groups/\(groupId)/configuration/\(namespace.encode())/\(name)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
