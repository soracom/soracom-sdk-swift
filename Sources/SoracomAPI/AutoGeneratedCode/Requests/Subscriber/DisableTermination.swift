//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Subscriber {

    /**
        Disable Termination of Subscriber.

        Disables termination of specified subscriber.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Subscriber/disableTermination)
    */
    public class func disableTermination(
        
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
