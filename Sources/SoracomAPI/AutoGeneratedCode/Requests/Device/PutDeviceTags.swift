//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Device {

    /**
        Description forthcoming.

        Updates device tags

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Device/putDeviceTags)
    */
    public class func putDeviceTags(
        
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path  = "/devices/\(deviceId)/tags"

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
