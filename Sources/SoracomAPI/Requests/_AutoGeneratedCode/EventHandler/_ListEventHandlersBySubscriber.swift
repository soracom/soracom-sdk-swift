//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    /**
        List Event Handlers related to Subscriber.

        Returns a list of event handlers related to the specified IMSI.

        Docs: https://dev.soracom.io/en/docs/api/#!/EventHandler/listEventHandlersBySubscriber
    */
    public class func _listEventHandlersBySubscriber(
        
        imsi: String,
        responseHandler: ResponseHandler<[EventHandlerModel]>? = nil
    ) ->   Request<[EventHandlerModel]> {

        let path  = "/event_handlers/subscribers/\(imsi)"

        let requestObject = Request<[EventHandlerModel]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get


        return requestObject
    }

}
