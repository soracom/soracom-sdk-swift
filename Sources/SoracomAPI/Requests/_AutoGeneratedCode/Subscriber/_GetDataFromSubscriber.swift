//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getDataFromSubscriber(
        
        imsi: String,
        from: Int? = nil,
        to: Int? = nil,
        sort: Sort? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        responseHandler: ResponseHandler<[DataEntry]>? = nil
    ) ->   Request<[DataEntry]> {

    let path = "/subscribers/{imsi}/data".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[DataEntry]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "from": from,
            "to": to,
            "sort": sort,
            "limit": limit,
            "lastEvaluatedKey": lastEvaluatedKey
        ])

        return requestObject
    }

}
