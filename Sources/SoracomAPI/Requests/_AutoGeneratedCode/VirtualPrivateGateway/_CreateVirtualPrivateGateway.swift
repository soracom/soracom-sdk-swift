//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _createVirtualPrivateGateway(
        createVirtualPrivateGatewayRequest: CreateVirtualPrivateGatewayRequest, 
        responseHandler: ResponseHandler<VirtualPrivateGateway>? = nil
    ) ->   Request<VirtualPrivateGateway> {

        let path  = "/virtual_private_gateways"

        let requestObject = Request<VirtualPrivateGateway>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = createVirtualPrivateGatewayRequest.toData()
        requestObject.expectedHTTPStatus = 201
        requestObject.method = .post


        return requestObject
    }

}
