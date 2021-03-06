//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Delete Group Tag.

        Deletes tag from the specified group.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Group/deleteGroupTag)
    */
    public class func deleteGroupTag(
        
        groupId: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/groups/\(groupId)/tags/\(tagName)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
