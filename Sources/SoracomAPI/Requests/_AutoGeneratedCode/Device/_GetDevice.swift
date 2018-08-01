//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getDevice(
        
        deviceId: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path = "/devices/{device_id}".replacingOccurrences(of: "{" + "deviceId" + "}", with: "\(deviceId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "model": model as Any
        ])

        return requestObject
    }

}
