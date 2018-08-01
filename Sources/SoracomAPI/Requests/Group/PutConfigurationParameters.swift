extension Request {

    /// Adds/updates parameters for the specified group. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/putConfigurationParameters)

    public class func putConfigurationParameters(
        parameters: [GroupConfigurationUpdateRequest], 
        groupId: String,
        namespace: Namespace,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _putConfigurationParameters(parameters: parameters, groupId: groupId, namespace: namespace,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_putConfigurationParameters()) is not sufficient):

        return req
    }
}
