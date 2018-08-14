//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Get the specified resource of a device

        Docs: https://dev.soracom.io/en/docs/api/#!/Device/readDeviceResource
    */
    public class func _readDeviceResource(
        
        deviceId: String,
        object: String,
        instance: String,
        resource: String,
        model: Bool? = nil,
        responseHandler: ResponseHandler<ResourceInstance>? = nil
    ) ->   Request<ResourceInstance> {

        let path  = "/devices/\(deviceId)/\(object)/\(instance)/\(resource)"

        let requestObject = Request<ResourceInstance>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "model": model
        ])

        return requestObject
    }

}
