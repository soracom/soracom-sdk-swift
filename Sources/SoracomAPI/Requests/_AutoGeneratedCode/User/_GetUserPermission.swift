//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getUserPermission(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GetUserPermissionResponse>? = nil
    ) ->   Request<GetUserPermissionResponse> {

        let path = "/operators/{operator_id}/users/{user_name}/permission".replacingOccurrences(of: "{" + "operatorId" + "}", with: "\(operatorId)").replacingOccurrences(of: "{" + "userName" + "}", with: "\(userName)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<GetUserPermissionResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
