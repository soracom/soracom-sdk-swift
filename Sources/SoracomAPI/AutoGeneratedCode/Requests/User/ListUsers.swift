//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == [UserDetailResponse] {

    /**
        List Users.

        Returns a list of SAM users.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/User/listUsers)
    */
    public class func listUsers(
        
        operatorId: String,
        responseHandler: ResponseHandler<[UserDetailResponse]>? = nil
    ) ->   Request<[UserDetailResponse]> {

        let path  = "/operators/\(operatorId)/users"

        let requestObject = Request<[UserDetailResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
