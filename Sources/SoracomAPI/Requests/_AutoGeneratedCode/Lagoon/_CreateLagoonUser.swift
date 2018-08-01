//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createLagoonUser(
        request: LagoonUserCreationRequest, 
        responseHandler: ResponseHandler<LagoonUserCreationResponse>? = nil
    ) ->   Request<LagoonUserCreationResponse> {

        let path = "/lagoon/users" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<LagoonUserCreationResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
