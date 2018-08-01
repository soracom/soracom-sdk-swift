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

        let path = "/operators/{operator_id}/token".replacingOccurrences(of: "{" + "operatorId" + "}", with: "\(operatorId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<GenerateTokenResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
