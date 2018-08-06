//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createVpcPeeringConnection(
        vpcPeeringConnection: CreateVpcPeeringConnectionRequest, 
        vpgId: String,
        responseHandler: ResponseHandler<CreateVpcPeeringConnectionRequest>? = nil
    ) ->   Request<CreateVpcPeeringConnectionRequest> {

    let path = "/virtual_private_gateways/{vpg_id}/vpc_peering_connections".replacingOccurrences(of: "{" + "vpg_id" + "}", with: "\(vpgId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<CreateVpcPeeringConnectionRequest>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = vpcPeeringConnection.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
