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

        let path  = "/stats/air/subscribers/\(imsi)"

        let requestObject = Request<[AirStatsResponse]>.init(path, responseHandler: responseHandler)

        
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
