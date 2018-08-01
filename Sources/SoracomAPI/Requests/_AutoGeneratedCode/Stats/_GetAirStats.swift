//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getAirStats(
        
        imsi: String,
        from: Int,
        to: Int,
        period: Period,
        responseHandler: ResponseHandler<[AirStatsResponse]>? = nil
    ) ->   Request<[AirStatsResponse]> {

        let path = "/stats/air/subscribers/{imsi}".replacingOccurrences(of: "{" + "imsi" + "}", with: "\(imsi)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<[AirStatsResponse]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "from": from as Any,
            "to": to as Any,
            "period": period as Any
        ])

        return requestObject
    }

}
