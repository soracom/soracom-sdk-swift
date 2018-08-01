extension Request {

    /// [API docs](https://dev.soracom.io/en/docs/api/#!/Group/deleteGroupTag)

    public class func deleteGroupTag(
        
        groupId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _deleteGroupTag(groupId: groupId, tagName: tagName,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_deleteGroupTag()) is not sufficient):

        return req
    }
}
