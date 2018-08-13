//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _putConfigurationParameters(
        parameters: [GroupConfigurationUpdateRequest], 
        groupId: String,
        namespace: Namespace,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {

        let path  = "/groups/\(groupId)/configuration/\(namespace.encode())"

        let requestObject = Request<Group>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = parameters.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
