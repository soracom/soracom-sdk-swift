//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _executeDeviceResource(
        arg: Arg, 
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path = "/devices/{device_id}/{object}/{instance}/{resource}/execute".replacingOccurrences(of: "{" + "deviceId" + "}", with: "\(deviceId)").replacingOccurrences(of: "{" + "object" + "}", with: "\(object)").replacingOccurrences(of: "{" + "instance" + "}", with: "\(instance)").replacingOccurrences(of: "{" + "resource" + "}", with: "\(resource)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = arg.toData()
        requestObject.expectedHTTPStatus = 202
        requestObject.method = .post


        return requestObject
    }

}
