extension Request {

    public class func getBeamStats(
        
        imsi: String,
        from: Int,
        to: Int,
        period: Period,
        responseHandler: ResponseHandler<[BeamStatsResponse]>? = nil
    ) ->   Request<[BeamStatsResponse]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _getBeamStats(imsi: imsi, from: from, to: to, period: period,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_getBeamStats()) is not sufficient):

        return req
    }
}