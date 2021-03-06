//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Send data to a Sigfox device.

        Sends data to the specified Sigfox device. The data will be stored until the device sends a next uplink message. If another message destined for the same Sigfox device ID is already waiting to be sent, the existing message will be discarded, and the new message will be sent instead.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/SigfoxDevice/sendDataToSigfoxDevice)
    */
    public class func sendDataToSigfoxDevice(
        data: SigfoxData, 
        deviceId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/sigfox_devices/\(deviceId)/data"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = data.toData()
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .post


        return requestObject
    }

}
