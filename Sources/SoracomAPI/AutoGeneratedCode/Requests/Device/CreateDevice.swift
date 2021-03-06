//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Device {

    /**
        Description forthcoming.

        Creates a new Device

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Device/createDevice)
    */
    public class func createDevice(
        device: Device, 
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path  = "/devices"

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = device.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
