extension Request where T == NoResponseBody {

    /// Insert Air stats for testing in the sandbox. [Sandbox API docs](https://dev.soracom.io/jp/docs/api_sandbox/#!/Stats/insertAirStats)

    public class func insertAirStats(
        stats: InsertAirStatsRequest, 
        imsi: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        // First, call the auto-generated implmentation, created from the API spec:
        let req = _insertAirStats(stats: stats, imsi: imsi,  responseHandler: responseHandler)

        // FIXME: Mason 2016-03-21: this isn't actually working yet; I always get a HTTP 500 with HTML error message as response:
        //    RangeError: Invalid time value<br> &nbsp;at Date.toISOString (native)<br> &nbsp;at isoFormat ...

        return req
    }
}
