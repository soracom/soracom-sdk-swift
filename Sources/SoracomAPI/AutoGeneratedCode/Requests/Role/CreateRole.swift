//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == CreateRoleResponse {

    /**
        Create Role.

        Adds a new role.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Role/createRole)
    */
    public class func createRole(
        request: CreateOrUpdateRoleRequest, 
        operatorId: String,
        roleId: String,
        responseHandler: ResponseHandler<CreateRoleResponse>? = nil
    ) ->   Request<CreateRoleResponse> {

        let path  = "/operators/\(operatorId)/roles/\(roleId)"

        let requestObject = Request<CreateRoleResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
