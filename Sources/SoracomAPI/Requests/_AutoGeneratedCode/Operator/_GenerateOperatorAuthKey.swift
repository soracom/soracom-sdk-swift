//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Generate Operator AuthKey.

        Generates an AuthKey for the operator.

        Docs: https://dev.soracom.io/en/docs/api/#!/Operator/generateOperatorAuthKey
    */
    public class func _generateOperatorAuthKey(
        
        operatorId: String,
        responseHandler: ResponseHandler<GenerateOperatorsAuthKeyResponse>? = nil
    ) ->   Request<GenerateOperatorsAuthKeyResponse> {

        let path  = "/operators/\(operatorId)/auth_keys"

        let requestObject = Request<GenerateOperatorsAuthKeyResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
