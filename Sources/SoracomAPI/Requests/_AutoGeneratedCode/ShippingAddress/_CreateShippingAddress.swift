//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createShippingAddress(
        model: ShippingAddressModel, 
        operatorId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {

        let path  = "/operators/\(operatorId)/shipping_addresses"

        let requestObject = Request<String>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = model.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
