//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Activate Subscriber.

        Activates status of specified subscriber.

        Docs: https://dev.soracom.io/en/docs/api/#!/Subscriber/activateSubscriber
    */
    public class func _activateSubscriber(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/activate"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
