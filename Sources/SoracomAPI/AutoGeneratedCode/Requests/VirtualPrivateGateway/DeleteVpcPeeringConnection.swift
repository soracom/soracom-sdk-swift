//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Delete VPC Peering Connection.

        Deletes the specified VPC peering connection.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/VirtualPrivateGateway/deleteVpcPeeringConnection)
    */
    public class func deleteVpcPeeringConnection(
        
        vpgId: String,
        pcxId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/virtual_private_gateways/\(vpgId)/vpc_peering_connections/\(pcxId)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 204
        requestObject.method = .delete


        return requestObject
    }

}
