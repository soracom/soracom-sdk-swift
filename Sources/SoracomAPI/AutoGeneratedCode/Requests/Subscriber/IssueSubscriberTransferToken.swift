//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == IssueSubscriberTransferTokenResponse {

    /**
        Issue Subscribers Transfer Token.

        Sends the subscriber's inter-operator control transfer token to the control destination operator.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/Subscriber/issueSubscriberTransferToken)
    */
    public class func issueSubscriberTransferToken(
        request: IssueSubscriberTransferTokenRequest, 
        responseHandler: ResponseHandler<IssueSubscriberTransferTokenResponse>? = nil
    ) ->   Request<IssueSubscriberTransferTokenResponse> {

        let path  = "/subscribers/transfer_token/issue"

        let requestObject = Request<IssueSubscriberTransferTokenResponse>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = request.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
