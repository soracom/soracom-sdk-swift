//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == GetOperatorResponse {

    /**
        Get Operator.

        Returns information about the operator.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Operator/getOperator)
    */
    public class func getOperator(
        
        operatorId: String,
        responseHandler: ResponseHandler<GetOperatorResponse>? = nil
    ) ->   Request<GetOperatorResponse> {

        let path  = "/operators/\(operatorId)"

        let requestObject = Request<GetOperatorResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
