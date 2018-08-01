//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteRole(
        
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/operators/{operator_id}/roles/{role_id}".replacingOccurrences(of: "{" + "operatorId" + "}", with: "\(operatorId)").replacingOccurrences(of: "{" + "roleId" + "}", with: "\(roleId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .delete


        return requestObject
    }

}
