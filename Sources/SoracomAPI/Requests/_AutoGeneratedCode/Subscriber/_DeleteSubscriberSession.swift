//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteSubscriberSession(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path = "/subscribers/{imsi}/delete_session".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
