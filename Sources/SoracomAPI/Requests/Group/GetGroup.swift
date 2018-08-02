extension Request where T == Group {

    /// Returns the group specified by the group ID. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/getGroup)

    public class func getGroup(
        
        groupId: String,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getGroup(groupId: groupId,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getGroup()) is not sufficient):

        return req
    }
}
