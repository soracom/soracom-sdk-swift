//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Delete Subscriber Tag.

        Deletes a tag from the specified subscriber.

        Docs: https://dev.soracom.io/en/docs/api/#!/Subscriber/deleteSubscriberTag
    */
    public class func _deleteSubscriberTag(
        
        imsi: String,
        tagName: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/subscribers/\(imsi)/tags/\(tagName)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
