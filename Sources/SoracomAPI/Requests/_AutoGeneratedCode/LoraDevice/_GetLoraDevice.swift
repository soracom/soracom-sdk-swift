//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getLoraDevice(
        
        deviceId: String,
        responseHandler: ResponseHandler<LoraDevice>? = nil
    ) ->   Request<LoraDevice> {

        let path = "/lora_devices/{device_id}".replacingOccurrences(of: "{" + "deviceId" + "}", with: "\(deviceId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<LoraDevice>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
