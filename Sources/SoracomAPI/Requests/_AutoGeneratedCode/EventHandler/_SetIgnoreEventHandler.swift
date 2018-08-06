//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _setIgnoreEventHandler(
        
        imsi: String,
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

    let path = "/event_handlers/{handler_id}/subscribers/{imsi}/ignore".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)").replacingOccurrences(of: "{" + "handler_id" + "}", with: "\(handlerId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}