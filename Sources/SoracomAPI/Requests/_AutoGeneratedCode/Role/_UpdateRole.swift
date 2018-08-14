//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Update Role.

        Edits a role.

        Docs: https://dev.soracom.io/en/docs/api/#!/Role/updateRole
    */
    public class func _updateRole(
        request: CreateOrUpdateRoleRequest, 
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/operators/\(operatorId)/roles/\(roleId)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
