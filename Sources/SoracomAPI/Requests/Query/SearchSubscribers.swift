extension Request {

    public class func searchSubscribers(
        
        name: [String]? = nil,
        group: [String]? = nil,
        imsi: [String]? = nil,
        msisdn: [String]? = nil,
        iccid: [String]? = nil,
        serialNumber: [String]? = nil,
        tag: [String]? = nil,
        limit: Int? = nil,
        lastEvaluatedKey: String? = nil,
        searchType: SearchType? = nil,
        responseHandler: ResponseHandler<[Subscriber]>? = nil
    ) ->   Request<[Subscriber]> {


        // First, call the auto-generated implmentation, created from the API spec:
        let req = _searchSubscribers(name: name, group: group, imsi: imsi, msisdn: msisdn, iccid: iccid, serialNumber: serialNumber, tag: tag, limit: limit, lastEvaluatedKey: lastEvaluatedKey, searchType: searchType,  responseHandler: responseHandler)

        // Next, add code here (only if the auto-generated code (_searchSubscribers()) is not sufficient):

        return req
    }
}