//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _registerOrderedSim(
        
        orderId: String,
        responseHandler: ResponseHandler<String>? = nil
    ) ->   Request<String> {

        let path = "/orders/{order_id}/subscribers/register".replacingOccurrences(of: "{" + "orderId" + "}", with: "\(orderId)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<String>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
