extension Request {

    public class func listDataSourceResources(
        
        resourceType: ResourceType? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[DataSourceResourceMetadata]>? = nil
    ) ->   Request<[DataSourceResourceMetadata]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _listDataSourceResources(resourceType: resourceType, limit: limit, lastEvaluatedKey: lastEvaluatedKey,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_listDataSourceResources()) is not sufficient):

        return req
    }
}