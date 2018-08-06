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

    let path = "/device_object_models"
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<DeviceObjectModel>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = objectModelDefinition.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
