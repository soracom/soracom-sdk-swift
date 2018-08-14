//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        List Subscribers in a group.

        Returns a list of subscribers that belong to the specified group by group ID.

        Docs: https://dev.soracom.io/en/docs/api/#!/Group/listSubscribersInGroup
    */
    public class func _listSubscribersInGroup(
        
        groupId: String,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[Subscriber]>? = nil
    ) ->   Request<[Subscriber]> {

        let path  = "/groups/\(groupId)/subscribers"

        let requestObject = Request<[Subscriber]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
