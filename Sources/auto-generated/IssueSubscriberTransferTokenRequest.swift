// IssueSubscriberTransferTokenRequest.swift Generated by swagger-codegen ___SORACOM_SDK_SWIFT_SWAGGERER_CODE_GENERATION_METADATA___

import Foundation


public class IssueSubscriberTransferTokenRequest: PayloadConvertible {

    /** \u79FB\u7BA1\u5148\u30AA\u30DA\u30EC\u30FC\u30BF\u30FCEmail */
    public var transferDestinationOperatorEmail: String?
    /** \u79FB\u7BA1\u5148\u30AA\u30DA\u30EC\u30FC\u30BF\u30FCID */
    public var transferDestinationOperatorId: String?
    /** \u79FB\u7BA1\u3059\u308BIMSI\u30EA\u30B9\u30C8 */
    public var transferImsi: [String]?

    public required init(
        transferDestinationOperatorEmail: String? = nil, 
        transferDestinationOperatorId: String? = nil, 
        transferImsi: [String]? = nil
    ) {
        self.transferDestinationOperatorEmail = transferDestinationOperatorEmail
        self.transferDestinationOperatorId = transferDestinationOperatorId
        self.transferImsi = transferImsi
        
    }

    // MARK: PayloadConvertible

    public func toPayload() -> Payload {

        let payload: Payload = [:]

        payload[.transferDestinationOperatorEmail] = transferDestinationOperatorEmail
        payload[.transferDestinationOperatorId] = transferDestinationOperatorId
        payload[.transferImsi] = transferImsi

        return payload;
    }

    public static func from(_ payload: Payload?) -> Self? {
        guard let payload = payload else {
            return nil
        }

        _ = payload // suppress compiler warnings when payload isn't used in generated code

        let result = self.init()

        result.transferDestinationOperatorEmail = payload.getString(.transferDestinationOperatorEmail)
        result.transferDestinationOperatorId = payload.getString(.transferDestinationOperatorId)
        result.transferImsi = payload.getStringArray(.transferImsi)
        return result
    }

}

public typealias IssueSubscriberTransferTokenRequestList = [IssueSubscriberTransferTokenRequest]