//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

public final class ActionConfigProperty: Codable, Equatable {

    public enum ExecutionDateTimeConst: String, Codable {
        case immediately = "IMMEDIATELY"
        case beginningofnextmonth = "BEGINNING_OF_NEXT_MONTH"
        case beginningofnextday = "BEGINNING_OF_NEXT_DAY"
        case afteroneday = "AFTER_ONE_DAY"
        case never = "NEVER"

        public static let cases: [ExecutionDateTimeConst] = [
          .immediately,
          .beginningofnextmonth,
          .beginningofnextday,
          .afteroneday,
          .never,
        ]
    }

    /** ExecuteWebRequestAction の時のみ有効 */
    public enum HttpMethod: String, Codable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"

        public static let cases: [HttpMethod] = [
          .get,
          .post,
          .put,
          .delete,
        ]
    }

    /** ChangeSpeedClassAction の時のみ有効 */
    public enum SpeedClass: String, Codable {
        case s1Minimum = "s1.minimum"
        case s1Slow = "s1.slow"
        case s1Standard = "s1.standard"
        case s1Fast = "s1.fast"

        public static let cases: [SpeedClass] = [
          .s1Minimum,
          .s1Slow,
          .s1Standard,
          .s1Fast,
        ]
    }

    public var executionDateTimeConst: ExecutionDateTimeConst

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var accessKey: String?

    /** ExecuteWebRequestAction の時のみ有効(任意) */
    public var body: String?

    /** ExecuteWebRequestAction の時のみ有効 */
    public var contentType: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var endpoint: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var functionName: String?

    /** ExecuteWebRequestAction の時のみ有効(任意) */
    public var headers: [String: Any]?

    /** ExecuteWebRequestAction の時のみ有効 */
    public var httpMethod: HttpMethod?

    /** SendMailAction, SendMailToOperatorAction の時のみ有効 */
    public var message: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var parameter1: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var parameter2: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var parameter3: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var parameter4: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var parameter5: String?

    /** InvokeAWSLambdaAction の時のみ有効 */
    public var secretAccessKey: String?

    /** ChangeSpeedClassAction の時のみ有効 */
    public var speedClass: SpeedClass?

    /** SendMailAction, SendMailToOperatorAction の時のみ有効 */
    public var title: String?

    /** SendMailAction の時のみ有効 */
    public var to: String?

    /** 接続先URLとパラメーター ExecuteWebRequestAction の時のみ有効 */
    public var url: String?

    public init(executionDateTimeConst: ExecutionDateTimeConst, accessKey: String? = nil, body: String? = nil, contentType: String? = nil, endpoint: String? = nil, functionName: String? = nil, headers: [String: Any]? = nil, httpMethod: HttpMethod? = nil, message: String? = nil, parameter1: String? = nil, parameter2: String? = nil, parameter3: String? = nil, parameter4: String? = nil, parameter5: String? = nil, secretAccessKey: String? = nil, speedClass: SpeedClass? = nil, title: String? = nil, to: String? = nil, url: String? = nil) {
        self.executionDateTimeConst = executionDateTimeConst
        self.accessKey = accessKey
        self.body = body
        self.contentType = contentType
        self.endpoint = endpoint
        self.functionName = functionName
        self.headers = headers
        self.httpMethod = httpMethod
        self.message = message
        self.parameter1 = parameter1
        self.parameter2 = parameter2
        self.parameter3 = parameter3
        self.parameter4 = parameter4
        self.parameter5 = parameter5
        self.secretAccessKey = secretAccessKey
        self.speedClass = speedClass
        self.title = title
        self.to = to
        self.url = url
    }

    private enum CodingKeys: String, CodingKey {
        case executionDateTimeConst
        case accessKey
        case body
        case contentType
        case endpoint
        case functionName
        case headers
        case httpMethod
        case message
        case parameter1
        case parameter2
        case parameter3
        case parameter4
        case parameter5
        case secretAccessKey
        case speedClass
        case title
        case to
        case url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        executionDateTimeConst = try container.decode(.executionDateTimeConst)
        accessKey = try container.decodeIfPresent(.accessKey)
        body = try container.decodeIfPresent(.body)
        contentType = try container.decodeIfPresent(.contentType)
        endpoint = try container.decodeIfPresent(.endpoint)
        functionName = try container.decodeIfPresent(.functionName)
        headers = try container.decodeAnyIfPresent(.headers)
        httpMethod = try container.decodeIfPresent(.httpMethod)
        message = try container.decodeIfPresent(.message)
        parameter1 = try container.decodeIfPresent(.parameter1)
        parameter2 = try container.decodeIfPresent(.parameter2)
        parameter3 = try container.decodeIfPresent(.parameter3)
        parameter4 = try container.decodeIfPresent(.parameter4)
        parameter5 = try container.decodeIfPresent(.parameter5)
        secretAccessKey = try container.decodeIfPresent(.secretAccessKey)
        speedClass = try container.decodeIfPresent(.speedClass)
        title = try container.decodeIfPresent(.title)
        to = try container.decodeIfPresent(.to)
        url = try container.decodeIfPresent(.url)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(executionDateTimeConst, forKey: .executionDateTimeConst)
        try container.encodeIfPresent(accessKey, forKey: .accessKey)
        try container.encodeIfPresent(body, forKey: .body)
        try container.encodeIfPresent(contentType, forKey: .contentType)
        try container.encodeIfPresent(endpoint, forKey: .endpoint)
        try container.encodeIfPresent(functionName, forKey: .functionName)
        try container.encodeAnyIfPresent(headers, forKey: .headers)
        try container.encodeIfPresent(httpMethod, forKey: .httpMethod)
        try container.encodeIfPresent(message, forKey: .message)
        try container.encodeIfPresent(parameter1, forKey: .parameter1)
        try container.encodeIfPresent(parameter2, forKey: .parameter2)
        try container.encodeIfPresent(parameter3, forKey: .parameter3)
        try container.encodeIfPresent(parameter4, forKey: .parameter4)
        try container.encodeIfPresent(parameter5, forKey: .parameter5)
        try container.encodeIfPresent(secretAccessKey, forKey: .secretAccessKey)
        try container.encodeIfPresent(speedClass, forKey: .speedClass)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(to, forKey: .to)
        try container.encodeIfPresent(url, forKey: .url)
    }

    public func isEqual(to object: Any?) -> Bool {
      guard let object = object as? ActionConfigProperty else { return false }
      guard self.executionDateTimeConst == object.executionDateTimeConst else { return false }
      guard self.accessKey == object.accessKey else { return false }
      guard self.body == object.body else { return false }
      guard self.contentType == object.contentType else { return false }
      guard self.endpoint == object.endpoint else { return false }
      guard self.functionName == object.functionName else { return false }
      guard NSDictionary(dictionary: self.headers ?? [:]).isEqual(to: object.headers ?? [:]) else { return false }
      guard self.httpMethod == object.httpMethod else { return false }
      guard self.message == object.message else { return false }
      guard self.parameter1 == object.parameter1 else { return false }
      guard self.parameter2 == object.parameter2 else { return false }
      guard self.parameter3 == object.parameter3 else { return false }
      guard self.parameter4 == object.parameter4 else { return false }
      guard self.parameter5 == object.parameter5 else { return false }
      guard self.secretAccessKey == object.secretAccessKey else { return false }
      guard self.speedClass == object.speedClass else { return false }
      guard self.title == object.title else { return false }
      guard self.to == object.to else { return false }
      guard self.url == object.url else { return false }
      return true
    }

    public static func == (lhs: ActionConfigProperty, rhs: ActionConfigProperty) -> Bool {
        return lhs.isEqual(to: rhs)
    }
}
