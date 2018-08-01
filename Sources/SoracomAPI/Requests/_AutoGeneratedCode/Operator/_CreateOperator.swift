//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createOperator(
        request: RegisterOperatorsRequest, 
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/operators" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
