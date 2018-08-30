//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Device {

    /**
        Description forthcoming.

        Lets a device leave from a group

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Device/unsetDeviceGroup)
    */
    public class func unsetDeviceGroup(
        
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path  = "/devices/\(deviceId)/unset_group"

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
