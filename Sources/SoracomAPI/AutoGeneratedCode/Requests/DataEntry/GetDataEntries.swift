//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == [DataEntry] {

    /**
        Get data sent from a resource.

        Returns a list of data entries sent from a resource that match certain criteria. If the total number of entries does not fit in one page, a URL for accessing the next page is returned in the 'Link' header of the response.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/DataEntry/getDataEntries)
    */
    public class func getDataEntries(
        
        resourceType: ResourceType,
        resourceId: String,
        from: Int? = nil,
        to: Int? = nil,
        sort: Sort? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[DataEntry]>? = nil
    ) ->   Request<[DataEntry]> {

        let path  = "/data/\(resourceType.encode())/\(resourceId)"

        let requestObject = Request<[DataEntry]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "from": from,
            "to": to,
            "sort": sort,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
