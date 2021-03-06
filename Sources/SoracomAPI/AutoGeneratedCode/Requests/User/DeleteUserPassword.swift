//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Delete Password.

        Deletes the user's password.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/User/deleteUserPassword)
    */
    public class func deleteUserPassword(
        
        operatorId: String,
        userName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/operators/\(operatorId)/users/\(userName)/password"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .delete


        return requestObject
    }

}
