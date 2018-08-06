//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getSignupToken(
        auth: GetSignupTokenRequest, 
        email: String,
        responseHandler: ResponseHandler<GetSignupTokenResponse>? = nil
    ) ->   Request<GetSignupTokenResponse> {

    let path = "/sandbox/operators/token/{email}".replacingOccurrences(of: "{" + "email" + "}", with: "\(email)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<GetSignupTokenResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = auth.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}