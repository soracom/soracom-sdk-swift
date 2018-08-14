//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Updates a device object model

        Docs: https://dev.soracom.io/en/docs/api/#!/DeviceObjectModel/updateDeviceObjectModel
    */
    public class func _updateDeviceObjectModel(
        objectModelDefinition: DeviceObjectModel, 
        modelId: String,
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {

        let path  = "/device_object_models/\(modelId)"

        let requestObject = Request<DeviceObjectModel>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = objectModelDefinition.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
