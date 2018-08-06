//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listRoles(
        
        operatorId: String,
        responseHandler: ResponseHandler<[ListRolesResponse]>? = nil
    ) ->   Request<[ListRolesResponse]> {

    let path = "/operators/{operator_id}/roles".replacingOccurrences(of: "{" + "operator_id" + "}", with: "\(operatorId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[ListRolesResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}