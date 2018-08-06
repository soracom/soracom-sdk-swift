//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _putSubscriberTags(
        tags: [TagUpdateRequest], 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

    let path = "/subscribers/{imsi}/tags".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
