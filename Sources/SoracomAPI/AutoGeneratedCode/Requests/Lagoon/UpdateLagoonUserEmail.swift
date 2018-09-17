//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Update email address of a SORACOM Lagoon user

        Update email address of a SORACOM Lagoon user.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Lagoon/updateLagoonUserEmail)
    */
    public class func updateLagoonUserEmail(
        request: LagoonUserEmailUpdatingRequest, 
        lagoonUserId: Int,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/lagoon/users/\(lagoonUserId)/email"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
