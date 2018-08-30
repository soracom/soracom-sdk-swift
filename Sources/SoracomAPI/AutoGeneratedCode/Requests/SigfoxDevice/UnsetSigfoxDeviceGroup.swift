//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == SigfoxDevice {

    /**
        Unset Group of Sigfox device.

        Removes the group configuration from the specified Sigfox device.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/SigfoxDevice/unsetSigfoxDeviceGroup)
    */
    public class func unsetSigfoxDeviceGroup(
        
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {

        let path  = "/sigfox_devices/\(deviceId)/unset_group"

        let requestObject = Request<SigfoxDevice>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
