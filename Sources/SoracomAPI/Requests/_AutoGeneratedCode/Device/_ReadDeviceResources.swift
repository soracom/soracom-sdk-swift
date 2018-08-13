//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _readDeviceResources(
        
        deviceId: String,
        object: String,
        instance: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<ObjectInstance>? = nil
    ) ->   Request<ObjectInstance> {

        let path  = "/devices/\(deviceId)/\(object)/\(instance)"

        let requestObject = Request<ObjectInstance>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "model": model
        ])

        return requestObject
    }

}
