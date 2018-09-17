//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request where T == NoResponseBody {

    /**
        Update Event Handler.

        Updates the specified event handler. Please see also https://dev.soracom.io/en/docs/event_handler/

        [API Documentation](https://dev.soracom.io/en/docs/api/#!/EventHandler/updateEventHandler)
    */
    public class func updateEventHandler(
        eventHandlerModel: UpdateEventHandlerRequest, 
        handlerId: String,
        responseHandler: ResponseHandler<NoResponseBody>? = nil
    ) ->   Request<NoResponseBody> {

        let path  = "/event_handlers/\(handlerId)"

        let requestObject = Request<NoResponseBody>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = eventHandlerModel.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .put


        return requestObject
    }

}
