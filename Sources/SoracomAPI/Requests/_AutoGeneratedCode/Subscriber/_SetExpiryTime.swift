//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Update Expiry Time of Subscriber.

        Updates expiry time of specified subscriber.

        Docs: https://dev.soracom.io/en/docs/api/#!/Subscriber/setExpiryTime
    */
    public class func _setExpiryTime(
        request: ExpiryTime, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/set_expiry_time"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
