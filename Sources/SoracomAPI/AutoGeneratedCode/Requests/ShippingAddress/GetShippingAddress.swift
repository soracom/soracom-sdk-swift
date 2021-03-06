//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == GetShippingAddressResponse {

    /**
        Get shipping address.

        Returns a shipping address.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/ShippingAddress/getShippingAddress)
    */
    public class func getShippingAddress(
        
        operatorId: String,
        shippingAddressId: String,
        responseHandler: ResponseHandler<GetShippingAddressResponse>? = nil
    ) ->   Request<GetShippingAddressResponse> {

        let path  = "/operators/\(operatorId)/shipping_addresses/\(shippingAddressId)"

        let requestObject = Request<GetShippingAddressResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
