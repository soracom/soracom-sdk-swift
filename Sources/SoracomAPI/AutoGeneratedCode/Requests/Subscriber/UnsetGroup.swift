//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Subscriber {

    /**
        Unset Group to Subscriber.

        Removes the group configuration from the specified subscriber.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Subscriber/unsetGroup)
    */
    public class func unsetGroup(
        
        imsi: String,
        responseHandler: ResponseHandler<Subscriber>? = nil
    ) ->   Request<Subscriber> {

        let path  = "/subscribers/\(imsi)/unset_group"

        let requestObject = Request<Subscriber>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
