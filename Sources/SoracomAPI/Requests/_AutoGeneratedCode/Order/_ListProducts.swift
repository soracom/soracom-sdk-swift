//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listProducts(
        
        responseHandler: ResponseHandler<ListProductResponse>? = nil
    ) ->   Request<ListProductResponse> {

    let path = "/products"
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<ListProductResponse>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}