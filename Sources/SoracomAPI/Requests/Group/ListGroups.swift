extension Request where T == [Group] {

    /// Returns a list of groups. [API docs](https://dev.soracom.io/en/docs/api/#!/Group/listGroups)

    public class func listGroups(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[Group]>? = nil
    ) ->   Request<[Group]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listGroups(tagName: tagName, tagValue: tagValue, tagValueMatchMode: tagValueMatchMode, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listGroups()) is not sufficient):

        return req
    }
}
