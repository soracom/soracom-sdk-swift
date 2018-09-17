//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == DeviceObjectModel {

    /**
        Description forthcoming.

        Creates a new device object model

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/DeviceObjectModel/createDeviceObjectModel)
    */
    public class func createDeviceObjectModel(
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
