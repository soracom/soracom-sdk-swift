extension Request {

    public class func getAirStats(
        
        imsi: String,
        from: Int,
        to: Int,
        period: Period,
        responseHandler: ResponseHandler<[AirStatsResponse]>? = nil
    ) ->   Request<[AirStatsResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getAirStats(imsi: imsi, from: from, to: to, period: period,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getAirStats()) is not sufficient):

        return req
    }
}