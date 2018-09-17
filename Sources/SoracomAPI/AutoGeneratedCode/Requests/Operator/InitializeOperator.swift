//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == AuthResponse {

    /**
        Initialize operator account

        Performs sign-up, authentication to access to the SORACOM API and registration of payment method. To call this API, specify `email` and `password` for an operator which will be created on sandbox, `authKeyId` and `authKey` for a real operator on the production environment. An API Key and an API Token will be included in the response if successful. Specify the API Key and the API Token to requests afterwards

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Operator/initializeOperator)
    */
    public class func initializeOperator(
        request: InitRequest, 
        responseHandler: ResponseHandler<AuthResponse>? = nil
    ) ->   Request<AuthResponse> {

        let path  = "/sandbox/init"

        let requestObject = Request<AuthResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post
        requestObject.shouldSendAPIKeyAndTokenInHTTPHeaders = false


        return requestObject
    }

}
