//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _generateAuthToken(
        request: GenerateTokenRequest, 
        operatorId: String,
        responseHandler: ResponseHandler<GenerateTokenResponse>? = nil
    ) ->   Request<GenerateTokenResponse> {

    let path = "/operators/{operator_id}/token".replacingOccurrences(of: "{" + "operator_id" + "}", with: "\(operatorId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<GenerateTokenResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}