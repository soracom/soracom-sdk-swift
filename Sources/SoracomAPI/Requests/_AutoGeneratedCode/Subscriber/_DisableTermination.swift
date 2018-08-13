//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _disableTermination(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/disable_termination"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
