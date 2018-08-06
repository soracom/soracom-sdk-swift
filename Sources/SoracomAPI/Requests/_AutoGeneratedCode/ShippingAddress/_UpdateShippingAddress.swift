//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _updateShippingAddress(
        model: ShippingAddressModel, 
        operatorId: String,
        shippingAddressId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

    let path = "/operators/{operator_id}/shipping_addresses/{shipping_address_id}".replacingOccurrences(of: "{" + "operator_id" + "}", with: "\(operatorId)").replacingOccurrences(of: "{" + "shipping_address_id" + "}", with: "\(shippingAddressId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = model.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
