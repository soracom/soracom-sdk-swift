//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getGroup(
        
        groupId: String,
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {

        let path  = "/groups/\(groupId)"

        let requestObject = Request<Group>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
