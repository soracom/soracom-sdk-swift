extension Request {

    /// Returns a list of subscribers that belong to the specified group by group ID. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/listSubscribersInGroup)

    public class func listSubscribersInGroup(
        
        groupId: String,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listSubscribersInGroup(groupId: groupId, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // FIXME: tests needed and API doc is wrong? (about the response payload) Confirm and make PR against API spec ifg so

        return req
    }
}
