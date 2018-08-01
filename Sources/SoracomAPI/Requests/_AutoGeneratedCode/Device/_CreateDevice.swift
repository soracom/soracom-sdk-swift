//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createDevice(
        device: Device, 
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path = "/devices" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = device.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
