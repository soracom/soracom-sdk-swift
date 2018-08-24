//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Description forthcoming.

        Executes a resource of a device

        Docs: https://dev.soracom.io/en/docs/api/#!/Device/executeDeviceResource
    */
    public class func executeDeviceResource(
        arg: Arg, 
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/devices/\(deviceId)/\(object)/\(instance)/\(resource)/execute"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = arg.toData()
        requestObject.expectedHTTPStatus = 202
        requestObject.method = .post


        return requestObject
    }

}