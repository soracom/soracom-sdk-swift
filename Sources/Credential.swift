// Credential.swift Created by Mason Mark on 2016-07-15. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// This structure is the full credential object that is returned by the API server upon a successful `listCredentials()` or `createCredential()` request.
///
/// **NOTE:** `Credential` objects returned by the API server contain a `Credential` structure, but that structure may not (always does not?) include the `secretAccessKey` value.

public struct Credential: PayloadConvertible {
    
    var createDateTime   : Int64?
    var credentials      : Credentials?
    var credentialsId    : String?
    var description      : String?
    var lastUsedDateTime : Int64?
    var type             : String?
    var updateDateTime   : Int64?
    
    
    
    static func from(payload: Payload?) -> Credential? {
        
        guard let payload = payload else {
            return nil
        }
        
        var result = Credential()
        
        if let created = payload[.createDateTime] as? NSNumber {
            result.createDateTime = created.longLongValue
        }
        
        if let credentialsDict = payload[.credentials] as? [String : AnyObject],
            subload         = Payload.fromDictionary(credentialsDict),
            accessKeyId     = subload[.accessKeyId] as? String
        {
            let secret = subload[.secretAccessKey] as? String // this normally won't be present
            result.credentials = Credentials(accessKeyId: accessKeyId, secretAccessKey: secret)
        }
        
        result.credentialsId = payload[.credentialsId] as? String
        result.description   = payload[.description]   as? String
        
        if let lastUsed = payload[.lastUsedDateTime] as? NSNumber {
            result.lastUsedDateTime = lastUsed.longLongValue
        }
        
        result.type = payload[.type] as? String
        
        if let updated = payload[.updateDateTime] as? NSNumber {
            result.updateDateTime = updated.longLongValue
        }
        return result
    }
    
    func toPayload() -> Payload {
        
        // FIXME: this serialization code is pathologically verbose and redundant...
        
        let result: Payload = [:]
        
        if let createDateTime = createDateTime {
            result[.createDateTime] = NSNumber(longLong: createDateTime)
        }
        
        if let credentials = credentials {
            result[.credentials] = credentials.toPayload()
        }
        
        if let credentialsId = credentialsId {
            result[.credentialsId] = credentialsId
        }
        
        if let description = description {
            result[.description] = description
        }
        
        if let lastUsedDateTime = lastUsedDateTime {
            result[.lastUsedDateTime] = NSNumber(longLong: lastUsedDateTime)
        }
        
        if let type = type {
            result[.type] = type
        }
        
        if let updateDateTime = updateDateTime {
            result[.updateDateTime] = NSNumber(longLong: updateDateTime)
        }
        
        return result
    }
}


extension Credential {
    
    /// A convenience initializer mainly for automated tests.
    
    init(description: String) {
        self.description = description
    }
}


public typealias CredentialList = [Credential]


/// This structure contains the raw credential values pertaining to a foreign service like AWS.

public struct Credentials: PayloadConvertible {
    
    var accessKeyId: String     = ""
    var secretAccessKey: String? = nil
    
    func toPayload() -> Payload {
        
        let result: Payload = [
            .accessKeyId     : accessKeyId,
            ]
        
        if let k = secretAccessKey {
            result[.secretAccessKey] = k
        }
        
        return result
    }
    
    public static func from(payload: Payload?) -> Credentials? {
        
        guard let payload = payload else {
            return nil
        }
        
        var result             = Credentials()
        result.accessKeyId     = payload[.accessKeyId]     as? String ?? ""
        result.secretAccessKey = payload[.secretAccessKey] as? String
        
        return result
    }
}


/// This structure contains the values used to create or update a Credentials object.

public struct CredentialOptions: PayloadConvertible {
    
    var type: String
    var description: String
    var credentials: Credentials = Credentials()
    
    func toPayload() -> Payload {
        
        let result: Payload = [
            .type        : type,
            .description : description,
            .credentials : credentials.toPayload()
        ]
        return result
    }
}
