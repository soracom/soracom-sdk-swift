//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getPayerInformation(
        
        responseHandler: ResponseHandler<RegisterPayerInformationModel>? = nil
    ) ->   Request<RegisterPayerInformationModel> {

        let path = "/payment_statements/payer_information" // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<RegisterPayerInformationModel>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
