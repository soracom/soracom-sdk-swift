//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _setLoraDeviceGroup(
        group: Group, 
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {

        let path  = "/lora_devices/\(deviceId)/set_group"

        let requestObject = Request<LoraDevice>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = group.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
