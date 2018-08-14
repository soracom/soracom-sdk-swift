//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Returns a list of device object models

        Docs: https://dev.soracom.io/en/docs/api/#!/DeviceObjectModel/listDeviceObjectModels
    */
    public class func _listDeviceObjectModels(
        
        lastEvaluatedKey: String? = nil,
        limit: Int? = nil,
        responseHandler: ResponseHandler<[DeviceObjectModel]>? = nil
    ) ->   Request<[DeviceObjectModel]> {

        let path  = "/device_object_models"

        let requestObject = Request<[DeviceObjectModel]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "lastEvaluatedKey": lastEvaluatedKey,
            "limit": limit
        ])

        return requestObject
    }

}
