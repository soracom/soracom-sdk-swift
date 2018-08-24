//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == [DataSourceResourceMetadata] {

    /**
        Get the list of data source resources

        Returns a list of data source resources that have sent data from resources that belong to the operator. If the total number of entries does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.

        Docs: https://dev.soracom.io/en/docs/api/#!/DataEntry/listDataSourceResources
    */
    public class func listDataSourceResources(
        
        resourceType: ResourceType? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[DataSourceResourceMetadata]>? = nil
    ) ->   Request<[DataSourceResourceMetadata]> {

        let path  = "/data/resources"

        let requestObject = Request<[DataSourceResourceMetadata]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "resourceType": resourceType,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}