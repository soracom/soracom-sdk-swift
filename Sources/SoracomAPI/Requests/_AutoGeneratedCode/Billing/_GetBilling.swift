//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getBilling(
        
        yyyyMM: String,
        responseHandler: ResponseHandler<MonthlyBill>? = nil
    ) ->   Request<MonthlyBill> {

        let path = "/bills/{yyyyMM}".replacingOccurrences(of: "{" + "yyyyMM" + "}", with: "\(yyyyMM)") // This nonsense should be fixed in the code generator, we might do a PR for at some point...

        let requestObject = Request<MonthlyBill>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
