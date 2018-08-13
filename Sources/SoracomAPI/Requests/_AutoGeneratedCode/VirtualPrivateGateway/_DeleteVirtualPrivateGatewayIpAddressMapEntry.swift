//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _deleteVirtualPrivateGatewayIpAddressMapEntry(
        
        vpgId: String,
        key: String,
        responseHandler: ResponseHandler<IpAddressMapEntry>? = nil
    ) ->   Request<IpAddressMapEntry> {

        let path  = "/virtual_private_gateways/\(vpgId)/ip_address_map/\(key)"

        let requestObject = Request<IpAddressMapEntry>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
