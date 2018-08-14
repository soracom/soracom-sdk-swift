//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Has User Password.

        Retrieves whether the SAM user has a password or not.

        Docs: https://dev.soracom.io/en/docs/api/#!/User/hasUserPassword
    */
    public class func _hasUserPassword(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GetUserPasswordResponse>? = nil
    ) ->   Request<GetUserPasswordResponse> {

        let path  = "/operators/\(operatorId)/users/\(userName)/password"

        let requestObject = Request<GetUserPasswordResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
