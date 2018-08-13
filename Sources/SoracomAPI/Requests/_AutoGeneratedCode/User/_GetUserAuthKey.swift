//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getUserAuthKey(
        
        operatorId: String,
        userName: String,
        authKeyId: String,
        responseHandler: ResponseHandler<AuthKeyResponse>? = nil
    ) ->   Request<AuthKeyResponse> {

        let path  = "/operators/\(operatorId)/users/\(userName)/auth_keys/\(authKeyId)"

        let requestObject = Request<AuthKeyResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
