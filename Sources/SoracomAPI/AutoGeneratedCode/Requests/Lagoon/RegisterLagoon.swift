//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == LagoonRegistrationResponse {

    /**
        Register (activate) SORACOM Lagoon

        Register (activate) SORACOM Lagoon. This API is only allowed to operate by root account.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Lagoon/registerLagoon)
    */
    public class func registerLagoon(
        request: LagoonRegistrationRequest, 
        responseHandler: ResponseHandler<LagoonRegistrationResponse>? = nil
    ) ->   Request<LagoonRegistrationResponse> {

        let path  = "/lagoon/register"

        let requestObject = Request<LagoonRegistrationResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
