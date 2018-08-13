//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _registerLoraDevice(
        loraDevice: RegisterLoraDeviceRequest, 
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {

        let path  = "/lora_devices/\(deviceId)/register"

        let requestObject = Request<LoraDevice>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = loraDevice.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
