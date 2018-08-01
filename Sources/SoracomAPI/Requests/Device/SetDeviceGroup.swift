extension Request {

    public class func setDeviceGroup(
        groupId: GroupId, 
        deviceId: String,
        responseHandler: ResponseHandler<Device>? = nil
    ) ->   Request<Device> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setDeviceGroup(groupId: groupId, deviceId: deviceId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setDeviceGroup()) is not sufficient):

        return req
    }
}