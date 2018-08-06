//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listSessionEvents(
        
        imsi: String,
        from: Int? = nil,
        to: Int? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[SessionEvent]>? = nil
    ) ->   Request<[SessionEvent]> {

    let path = "/subscribers/{imsi}/events/sessions".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[SessionEvent]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "from": from,
            "to": to,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}