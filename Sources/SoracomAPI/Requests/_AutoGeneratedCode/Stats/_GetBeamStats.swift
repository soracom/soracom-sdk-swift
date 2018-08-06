//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getBeamStats(
        
        imsi: String,
        from: Int,
        to: Int,
        period: Period,
        responseHandler: ResponseHandler<[BeamStatsResponse]>? = nil
    ) ->   Request<[BeamStatsResponse]> {

    let path = "/stats/beam/subscribers/{imsi}".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[BeamStatsResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "from": from,
            "to": to,
            "period": period
        ])

        return requestObject
    }

}
