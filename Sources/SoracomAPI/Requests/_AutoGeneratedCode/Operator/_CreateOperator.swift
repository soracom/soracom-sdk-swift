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

    let path = "/operators"
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
