//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _sendDataToLoraDevice(
        data: LoraData, 
        deviceId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

    let path = "/lora_devices/{device_id}/data".replacingOccurrences(of: "{" + "device_id" + "}", with: "\(deviceId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = data.toData()
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .post


        return requestObject
    }

}
