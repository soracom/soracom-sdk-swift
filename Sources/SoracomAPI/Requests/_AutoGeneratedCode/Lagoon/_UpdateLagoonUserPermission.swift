//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Update permission of a SORACOM Lagoon user

        Update permission of a SORACOM Lagoon user.

        Docs: https://dev.soracom.io/en/docs/api/#!/Lagoon/updateLagoonUserPermission
    */
    public class func _updateLagoonUserPermission(
        request: LagoonUserPermissionUpdatingRequest, 
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/lagoon/users/\(lagoonUserId)/permission"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
