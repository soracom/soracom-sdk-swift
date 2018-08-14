//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        Description forthcoming.

        Export payer information.

        Docs: https://dev.soracom.io/en/docs/api/#!/Payment/getPayerInformation
    */
    public class func _getPayerInformation(
        
        responseHandler: ResponseHandler<RegisterPayerInformationModel>? = nil
    ) ->   Request<RegisterPayerInformationModel> {

        let path  = "/payment_statements/payer_information"

        let requestObject = Request<RegisterPayerInformationModel>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
