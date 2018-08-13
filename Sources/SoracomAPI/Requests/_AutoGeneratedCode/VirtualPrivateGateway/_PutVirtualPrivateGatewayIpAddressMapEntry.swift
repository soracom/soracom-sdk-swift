//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _putVirtualPrivateGatewayIpAddressMapEntry(
        putIpAddressMapEntryRequest: PutIpAddressMapEntryRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<IpAddressMapEntry>? = nil
    ) ->   Request<IpAddressMapEntry> {

        let path  = "/virtual_private_gateways/\(vpgId)/ip_address_map"

        let requestObject = Request<IpAddressMapEntry>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = putIpAddressMapEntryRequest.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
