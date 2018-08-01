//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listOperatorAuthKeys(
        
        operatorId: String,
        responseHandler: ResponseHandler<[AuthKeyResponse]>? = nil
    ) ->   Request<[AuthKeyResponse]> {

        let path = "/operators/{operator_id}/auth_keys".replacingOccurrences(of: "{" + "operatorId" + "}", with: "\(operatorId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<[AuthKeyResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
