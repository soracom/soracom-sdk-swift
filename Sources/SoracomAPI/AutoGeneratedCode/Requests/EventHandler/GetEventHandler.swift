//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == EventHandlerModel {

    /**
        Get Event Handler.

        Returns information about the specified event handler.

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/EventHandler/getEventHandler)
    */
    public class func getEventHandler(
        
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
