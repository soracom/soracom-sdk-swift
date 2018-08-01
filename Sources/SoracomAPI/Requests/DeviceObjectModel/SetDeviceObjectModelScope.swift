extension Request {

    public class func setDeviceObjectModelScope(
        scope: SetDeviceObjectModelScopeRequest, 
        modelId: String,
        responseHandler: ResponseHandler<DeviceObjectModel>? = nil
    ) ->   Request<DeviceObjectModel> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _setDeviceObjectModelScope(scope: scope, modelId: modelId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_setDeviceObjectModelScope()) is not sufficient):

        return req
    }
}