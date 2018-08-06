//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listVirtualPrivateGateways(
        
        tagName: String? = nil,
        tagValue: String? = nil,
        tagValueMatchMode: TagValueMatchMode? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[VirtualPrivateGateway]>? = nil
    ) ->   Request<[VirtualPrivateGateway]> {

    let path = "/virtual_private_gateways"
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[VirtualPrivateGateway]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "tagName": tagName,
            "tagValue": tagValue,
            "tagValueMatchMode": tagValueMatchMode,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
