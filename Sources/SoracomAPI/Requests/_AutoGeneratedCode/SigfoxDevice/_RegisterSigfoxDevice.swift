//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension Request {

    public class func _registerSigfoxDevice(
        registrationRequest: SigfoxRegistrationRequest, 
        deviceId: String,
        responseHandler: ResponseHandler<SigfoxDevice>? = nil
    ) ->   Request<SigfoxDevice> {

    let path = "/sigfox_devices/{device_id}/register".replacingOccurrences(of: "{" + "device_id" + "}", with: "\(deviceId)")
      // FIXME: This path-expansion nonsense should be done in the code generation step (custom Stencil filter maybe?), and not done at all to paths that don't need it...

        let requestObject = Request<SigfoxDevice>.init(path, responseHandler: responseHandler)

        requestObject.messageBody = registrationRequest.toData()
        requestObject.expectedHTTPStatus = 200
        requestObject.method = .post


        return requestObject
    }

}
