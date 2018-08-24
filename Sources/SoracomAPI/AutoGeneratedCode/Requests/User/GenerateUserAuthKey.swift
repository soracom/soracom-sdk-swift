//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == GenerateUserAuthKeyResponse {

    /**
        Generate AuthKey.

        Generates an AuthKey for the SAM user.

        Docs: https://dev.soracom.io/en/docs/api/#!/User/generateUserAuthKey
    */
    public class func generateUserAuthKey(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<GenerateUserAuthKeyResponse>? = nil
    ) ->   Request<GenerateUserAuthKeyResponse> {

        let path  = "/operators/\(operatorId)/users/\(userName)/auth_keys"

        let requestObject = Request<GenerateUserAuthKeyResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}