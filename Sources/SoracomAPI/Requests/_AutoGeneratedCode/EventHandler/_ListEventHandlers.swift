//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _listEventHandlers(
        
        target: Target? = nil,
        responseHandler: ResponseHandler<[EventHandlerModel]>? = nil
    ) ->   Request<[EventHandlerModel]> {

    let path = "/event_handlers"
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<[EventHandlerModel]>.init(path, responseHandler: responseHandler)

        
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .get

        requestObject.query = makeQueryDictionary([
            "target": target
        ])

        return requestObject
    }

}
