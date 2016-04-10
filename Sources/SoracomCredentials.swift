// SoracomCredentials.swift Created by mason on 2016-02-21. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

/// Simple object to represent a set of Soracom credentials (either a Soracom root acccount, SAM user, AuthKey id/secret pair, or API Key / API Token pair). The first three types of credentials are used for authentication, while the last type is typically passed in HTTP headers to authorize individual API operations. `SoracomCredentials` can represent any/all of them, however, and can read/write to/from secure persistent storage (e.g., the system keychain on iOS and OSX).

public struct SoracomCredentials: Equatable {
    
    var type           = SoracomCredentialType.RootAccount
    var emailAddress   = ""
    var operatorID     = ""
    var username       = ""
    var password       = ""
    var authKeyID      = ""
    var authKeySecret  = ""
    var apiKey         = ""
    var apiToken       = ""
    
    // FIXME: add this to stash the expire time of credentials (for KeyAndToken case):    var expirationDate
    
    
    /// The canonical initializer, allows setting any/all properties.
    
    init(type: SoracomCredentialType = .RootAccount, emailAddress: String = "", operatorID: String = "", username: String = "", password: String = "", authKeyID: String = "", authKeySecret: String = "", apiKey: String = "", apiToken: String = "") {
        self.type          = type
        self.emailAddress  = emailAddress
        self.operatorID    = operatorID
        self.username      = username
        self.password      = password
        self.authKeyID     = authKeyID
        self.authKeySecret = password
        self.apiKey        = apiKey
        self.apiToken      = apiToken
    }
    
    
    /// Initialize a new credentials struct from a dictionary, which is (presumably) a dictionary generated with `dictionaryRepresentation()`.
    
    init(withDictionary dictionary: Dictionary<String, String>) {
        
        if let typeName = dictionary[kType], validType = SoracomCredentialType(rawValue: typeName) {
            self.type = validType
        }
        
        emailAddress  = dictionary[kEmailAddress] ?? ""
        operatorID    = dictionary[kOperatorId] ?? ""
        username      = dictionary[kUsername] ?? ""
        password      = dictionary[kPassword] ?? ""
        authKeyID     = dictionary[kAuthKeyID] ?? ""
        authKeySecret = dictionary[kAuthKeySecret] ?? ""
        apiKey        = dictionary[kAPIKey] ?? ""
        apiToken      = dictionary[kAPIToken] ?? ""
    }
    
    
    /// Initialize a credentials struct from the data stored in secure persistent storage (system keychain) with the given `identifier`. A `nil` value for `identifier` means the default identifier should be used (`SoracomCredentials.keychainItemDefault`).
    
    init(withStorageIdentifier identifier: String?) {
        
        let identifier = identifier ?? SoracomCredentials.defaultStorageIdentifier
        
        if let data = Keychain.read(identifier), let dict = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String:String] {
            self.init(withDictionary: dict)
        } else {
            self.init()
        }
    }
    
    
    /// Initialize and return a new credentials instance based on the values (if any) stored in secure persistent storage, using the default storage identifier for `type`. If nothing is stored for that identifier, a new empty credentials instance will be returned.
    
    init(withStoredType type: SoracomCredentialType) {
        self.init(withStorageIdentifier: type.defaultStorageIdentifier())
    }
    
    
    /// Write the credentials to secure persistent storage (system keychain). If `identifier` is `nil`, then the default storage identifier for the credentials type is used. Any credentials that were previously stored with the same `identifier` are overwritten. This means that you can choose not to provide an identifier if you only need to store a maximimum of one credentials structure of each type (the default key is provided by `SoracomCredentialType`, and is unique per-type). Also, if `replaceDefault` is true (which it is by default), the credentials are also separately persisted using the identifier `SoracomCredentials.defaultStorageIdentifier`. This allows retrieval of the "default" credentials (the meaning of which is application-specific), regardless of type.
    ///
    /// This makes it easy by default to retrieve the last-saved credentials of each type, and also to retrieve the last-saved credentials regardless of type.
    
    func writeToSecurePersistentStorage(identifier: String? = nil, replaceDefault : Bool = true) -> Bool {
        
        let identifier = identifier ?? type.defaultStorageIdentifier()
        let data       = NSKeyedArchiver.archivedDataWithRootObject(dictionaryRepresentation())
        var result     = Keychain.write(identifier, data: data)
        
        if (replaceDefault) {
            let identifier = SoracomCredentials.defaultStorageIdentifier
            result = result && Keychain.write(identifier, data: data)
        }
        
        return result
    }

    
    /// Serialize the receiver to a dictionary. (You can use `init(withDictionary:)` to deserialize.)
    
    func dictionaryRepresentation() -> [String:String] {
        return [
            kType          : type.rawValue,
            kEmailAddress  : emailAddress,
            kOperatorId    : operatorID,
            kUsername      : username,
            kPassword      : password,
            kAuthKeyID     : authKeyID,
            kAuthKeySecret : authKeySecret,
            kAPIKey        : apiKey,
            kAPIToken      : apiToken,
            
            kAccountCredentialsStorageFormatVersion: "2"
        ]
    }
    
    
    /// The storage identifier used to look up the "default" credentials. This is similar to SoracomCredentialType.defaultStorageIdentifier(), except that it is used to store and retrieve the default credentials, whatever type they happen to be. (What "default" means is application-specific, and no assumptions are made in this SDK about how it is to be used.)
    
    static let defaultStorageIdentifier = "jp.soracom.soracom-sdk-swift.SoracomCredentials.Default"
}


// MARK: - Equatable conformance

public func ==(lhs: SoracomCredentials, rhs: SoracomCredentials) -> Bool
{
    return (lhs.type == rhs.type) &&
    (lhs.emailAddress == rhs.emailAddress) &&
    (lhs.operatorID == rhs.operatorID) &&
    (lhs.username == rhs.username) &&
    (lhs.password == rhs.password) &&
    (lhs.authKeyID == rhs.authKeyID) &&
    (lhs.authKeySecret == rhs.authKeySecret) &&
    (lhs.apiKey == rhs.apiKey) &&
    (lhs.apiToken == rhs.apiToken)
}


// MARK: - SoracomCredentialType enum

/// Defines the different types of authentication (see the [API Documentation](https://dev.soracom.io/jp/docs/api/#!/Auth/auth) for details).

enum SoracomCredentialType: String {
    
    case RootAccount
    case SAM
    case AuthKey
    case KeyAndToken
    
    
    /// Returns the default identifier used to store credentials data of a given type. If your client code only needs to store one (or fewer) set of credentials for each type, then you can choose to omit the identifier when using `writeToSecurePersistentStorage()` and the default identifier will be used.
    
    func defaultStorageIdentifier() -> String {
        switch self {
        default:
            return "jp.soracom.soracom-sdk-swift.SoracomCredentials.Default.\(self.rawValue)"
        }
    }
}


// MARK: - Private constants (dictionary serialization keys)

private let kType          = "type"
private let kEmailAddress  = "emailAddress"
private let kOperatorId    = "operatorID"
private let kUsername      = "username"
private let kPassword      = "password"
private let kAuthKeyID     = "authKeyID"
private let kAuthKeySecret = "authKeySecret"
private let kAPIKey        = "apiKey"
private let kAPIToken      = "apiToken"

private let kAccountCredentialsStorageFormatVersion = "accountCredentialsStorageFormatVersion"
