//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Delete LoRa device Tag.

        Deletes a tag from the specified LoRa device.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/LoraDevice/deleteLoraDeviceTag)
    */
    public class func deleteLoraDeviceTag(
        
        deviceId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/lora_devices/\(deviceId)/tags/\(tagName)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
