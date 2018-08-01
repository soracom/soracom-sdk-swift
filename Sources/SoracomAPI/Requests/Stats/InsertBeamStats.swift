extension Request where T == NoResponseBody {

    /// Insert Beam stats for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Stats/insertBeamStats)

    public class func insertBeamStats(
        stats: InsertBeamStatsRequest, 
        imsi: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        // First, call the auto-generated implmentation, created from the API spec:
        let req = _insertBeamStats(stats: stats, imsi: imsi,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_insertBeamStats()) is not sufficient):

        return req
    }
}
