//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Subscriber {

    /**
        Update Subscriber speed class.

        Changes the speed class of the specified subscriber.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Subscriber/updateSpeedClass)
    */
    public class func updateSpeedClass(
        speedClass: UpdateSpeedClassRequest, 
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/update_speed_class"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = speedClass.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
