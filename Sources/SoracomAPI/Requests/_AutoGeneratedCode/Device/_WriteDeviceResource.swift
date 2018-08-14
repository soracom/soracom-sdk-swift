//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Write value to a resource of a device

        Docs: https://dev.soracom.io/en/docs/api/#!/Device/writeDeviceResource
    */
    public class func _writeDeviceResource(
        value: Value, 
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/devices/\(deviceId)/\(object)/\(instance)/\(resource)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = value.toData()
        requestObject.expectedHTTPStatus = 202
        requestObject.method = .put


        return requestObject
    }

}
