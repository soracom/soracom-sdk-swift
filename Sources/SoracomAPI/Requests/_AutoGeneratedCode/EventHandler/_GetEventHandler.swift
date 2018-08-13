//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _getEventHandler(
        
        handlerId: String,
        responseHandler: ResponseHandler<EventHandlerModel>? = nil
    ) ->   Request<EventHandlerModel> {

        let path  = "/event_handlers/\(handlerId)"

        let requestObject = Request<EventHandlerModel>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
