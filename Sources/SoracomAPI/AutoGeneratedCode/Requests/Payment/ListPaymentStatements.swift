//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == ListPaymentStatementResponse {

    /**
        Description forthcoming.

        List payment statements.

        Docs: https://dev.soracom.io/en/docs/api/#!/Payment/listPaymentStatements
    */
    public class func listPaymentStatements(
        
        responseHandler: ResponseHandler<ListPaymentStatementResponse>? = nil
    ) ->   Request<ListPaymentStatementResponse> {

        let path  = "/payment_statements"

        let requestObject = Request<ListPaymentStatementResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}