//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createDeviceObjectModel(
        objectModelDefinition: DeviceObjectModel, 
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {

        let path  = "/device_object_models"

        let requestObject = Request<DeviceObjectModel>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = objectModelDefinition.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
