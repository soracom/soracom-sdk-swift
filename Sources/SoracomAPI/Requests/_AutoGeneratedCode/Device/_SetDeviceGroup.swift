//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _setDeviceGroup(
        groupId: GroupId, 
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {

        let path  = "/devices/\(deviceId)/set_group"

        let requestObject = Request<Device>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = groupId.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
