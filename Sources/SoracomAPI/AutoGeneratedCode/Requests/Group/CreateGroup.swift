//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == Group {

    /**
        Create Group.

        Create a new group.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Group/createGroup)
    */
    public class func createGroup(
        tags: CreateGroupRequest, 
        responseHandler: ResponseHandler<Group>? = nil
    ) ->   Request<Group> {

        let path  = "/groups"

        let requestObject = Request<Group>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = tags.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
