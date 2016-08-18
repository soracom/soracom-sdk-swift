// ActionConfig.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class ActionConfig: PayloadConvertible {

    public enum _type: String { 
        case ChangeSpeedClassAction = "ChangeSpeedClassAction"
        case InvokeAWSLambdaAction = "InvokeAWSLambdaAction"
        case ExecuteWebRequestAction = "ExecuteWebRequestAction"
        case SendMailAction = "SendMailAction"
        case SendMailToOperatorAction = "SendMailToOperatorAction"
    }
    public var properties: ActionConfigProperty?

    public var _type: _type?

    public required init(
        properties: ActionConfigProperty? = nil, 
        _type: /* FIXME enum wtf */_type = nil
    ) {
        self.properties = properties
        self._type = _type
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.properties] = properties
        payload[._type] = _type

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.properties = payload.getActionConfigProperty(.properties)
        // _type: WHUT FIXME-ENUM-CASE _type
        result._type = payload.get_type(._type)
        return result
    }

}

public typealias ActionConfigList = [ActionConfig]
