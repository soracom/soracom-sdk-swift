//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listUserRoles(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<[RoleResponse]>? = nil
    ) ->   Request<[RoleResponse]> {

        let path  = "/operators/\(operatorId)/users/\(userName)/roles"

        let requestObject = Request<[RoleResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
