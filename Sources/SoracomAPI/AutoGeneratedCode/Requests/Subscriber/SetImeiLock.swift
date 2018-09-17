//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Subscriber {

    /**
        Set IMEI lock configuration for Subscriber.

        Set IMEI that the subscriber should be locked to.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Subscriber/setImeiLock)
    */
    public class func setImeiLock(
        imeiLock: SetImeiLockRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/set_imei_lock"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = imeiLock.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
