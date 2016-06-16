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
    
    
    /// Reads/writes the default credentials object in the production namespace. The getter returns a blank credentials object if no credentials are stored. In the context of these tests and the SDK demo apps, the only reason actual production credentials are ever required is to create a new sandbox user for testing; that sandbox user's credentials are used for all other purposes (e.g. running tests against the sandbox, or playing with the API via the demo app).
    
    public static var productionCredentials: SoracomCredentials {
        get {
            return SoracomCredentials(withStorageIdentifier: nil, namespace: SoracomCredentials.storageNamespaceForProductionCredentials)
        }
        set {
            let creds = newValue ?? SoracomCredentials()
            // FIXME: implement delete() in Keychain, the above is stupid
            creds.writeToSecurePersistentStorage(namespace:SoracomCredentials.storageNamespaceForProductionCredentials, replaceDefault: true)
        }
    }
    
    
    /// Reads/writes the default credentials object in the production namespace. The getter returns a blank credentials object if no credentials are stored. In the context of these tests and the SDK demo apps, the sandbox credentials are used for all interactions with the Soracom API (via the API Sandbox), with the exception of creating the sandbox user (that step requires production SAM user credentials
    
    public static var sandboxCredentials: SoracomCredentials {
        get {
            return SoracomCredentials(withStorageIdentifier: nil, namespace: SoracomCredentials.storageNamespaceForSandboxCredentials)
        }
        set {
            let creds = newValue ?? SoracomCredentials()
            // FIXME: implement delete() in Keychain, the above is stupid
            creds.writeToSecurePersistentStorage(namespace:SoracomCredentials.storageNamespaceForSandboxCredentials, replaceDefault: true)
        }
    }
    
    // FIXME: change above 2 to methods, not computed properties, because otherwise there is no way to handle keychain read/write errors
    
        
    /// The canonical initializer, allows setting any/all properties.
    
    init(type: SoracomCredentialType = .RootAccount, emailAddress: String = "", operatorID: String = "", username: String = "", password: String = "", authKeyID: String = "", authKeySecret: String = "", apiKey: String = "", apiToken: String = "") {
        self.type          = type
        self.emailAddress  = emailAddress
        self.operatorID    = operatorID
        self.username      = username
        self.password      = password
        self.authKeyID     = authKeyID
        self.authKeySecret = authKeySecret
        self.apiKey        = apiKey
        self.apiToken      = apiToken // FIXME: rename to 'token' for consistency with API keys
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
    
    
    /// Initialize from data in JSON format (e.g., that produced by `toJSON()`).
    
    init(jsonData: NSData) {
        
        var dict: [String: String]? = nil
        
        do {
            let decoded = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
            if let decoded = decoded as? [String:String] {
                dict = decoded
            }
        } catch {
            print("Note: SoracomCredentials init(jsonData:) failed.")
            // Could happen, e.g. if user edited data in Keychain
        }
        
        if let dict = dict {
            self.init(withDictionary: dict)
        } else {
            self.init()
        }
    }
    
    
    /// Initialize a credentials struct from the data stored in secure persistent storage (system keychain) with the given `identifier`. A `nil` value for `identifier` means the default identifier should be used (`SoracomCredentials.defaultStorageIdentifier`).
    ///
    /// The `namespace` parameter can typically be omitted.
    
    init(withStorageIdentifier identifier: String?, namespace: NSUUID? = nil) {
        
        let base       = identifier ?? SoracomCredentials.defaultStorageIdentifier
        let identifier = SoracomCredentials.buildNamespacedIdentifier( base, namespace: namespace )
        
        if let data = Keychain.read(identifier) {
            self.init(jsonData: data)
        } else {
            self.init()
        }
    }
    
    // FIXME: SoracomCredentials(withStorageIdentifier: nil) is how you look up the default credentials but that it not at all intuitive
    
    
    /// Write the credentials to secure persistent storage (system keychain). If `identifier` is `nil`, then the default storage identifier for the credentials type is used. Any credentials that were previously stored with the same `identifier` are overwritten. This means that you can choose not to provide an identifier if you only need to store a maximimum of one credentials structure of each type (the default key is provided by `SoracomCredentialType`, and is unique per-type). Also, if `replaceDefault` is true (which it is by default), the credentials are also separately persisted using the identifier `SoracomCredentials.defaultStorageIdentifier`. This allows retrieval of the "default" credentials (the meaning of which is application-specific), regardless of type.
    ///
    /// This makes it easy by default to retrieve the last-saved credentials of each type, and also to retrieve the last-saved credentials regardless of type.
    ///
    /// The `namespace` parameter can typically be omitted.
    
    func writeToSecurePersistentStorage(identifier: String? = nil, namespace: NSUUID? = nil, replaceDefault : Bool = false) -> Bool {
                
        let base       = identifier ?? type.defaultStorageIdentifier()
        let identifier = SoracomCredentials.buildNamespacedIdentifier(base, namespace: namespace)
        let data       = toJSONData()
        var result     = Keychain.write(identifier, data: data)
        
        if (replaceDefault) {
            let base       = SoracomCredentials.defaultStorageIdentifier
            let identifier = SoracomCredentials.buildNamespacedIdentifier(base, namespace: namespace)
            result         = result && Keychain.write(identifier, data: data)
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
        
        // FIXME: are we using "toDictionary()" or "dictionaryRepresentation()"?? Make it consistent, please.
    }
    
    
    /// Returns an NSData instance, which contains the receiver's contents as JSON.
    
    func toJSONData() -> NSData {
        
        do {
            let dict = dictionaryRepresentation()
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: .PrettyPrinted)
            return jsonData
        } catch {
            fatalError("should be impossible: JSON serialization of credentials failed: \(error)")
        }
    }

    
    /// Returns true if all of the receiver's string properties are the empty string.
    var blank: Bool {
        let other = SoracomCredentials(type: self.type)
        return self == other
    }
    
    
    /// The storage identifier used to look up the "default" credentials. This is similar to SoracomCredentialType.defaultStorageIdentifier(), except that it is used to store and retrieve the default credentials, whatever type they happen to be. (What "default" means is application-specific, and no assumptions are made in this SDK about how it is to be used.)
    
    static let defaultStorageIdentifier = "SoracomCredentials.Default"
    
    
    /// The default storage namespace is a UUID that uniquely identifies a type of storage within the scope of a client application. An app that only stores credentials for one purpose will not normally need to change the default, or use multiple namespaces.
    ///
    /// When writing credentials to secure persistent storage, unique storage keys are created like this:
    ///
    /// *credential-type*.*app-identifier*.*namespace*
    ///
    /// In simple cases, all of these things can be inferred automatically and need not be specified. The credential type is determined by the `.type` value, the app identifier is based on the `bundleIdentifier` provided by NSBundle, and the default namespace is used.
    ///
    /// In a more complex case, such as an app that manages multiple Soracom accounts, the credentials pertaining to each account could be maintained separately by using a unique namespace for each account.

    static var defaultStorageNamespace: NSUUID = NSUUID(UUIDString: "00000000-0000-0000-0000-DEFDEFDEFDEF")!

    
    /// This credentials storage namespace is used when tests need **actual production** credentials. For example, some tests need credentials for a real Soracom SAM user, in order to create an account in the API sandbox. Writing any other credentials to this namespace should be avoided.
    
    static let storageNamespaceForProductionCredentials = NSUUID(UUIDString: "454BA030-3DBC-4D09-BFC3-35CE9C7BDFFF")!
    
    
    /// This credentials storage namespace is used when tests need working API Sandbox credentials. Most tests that make network requests to exercise API functions need these credentials. Writing any other credentials to this namespace should be avoided. **NOTE**: The UUID used for this namespace is intentially the same as the demo app uses, so that the demo app can be used to create a user in the API Sandbox that will then be used to run the tests which require a sandbox user.
    
    static let storageNamespaceForSandboxCredentials = NSUUID(UUIDString: "DEAE490F-0A00-49CD-B2AF-401215E15122")!
    
    
    /// /// This credentials storage namespace is used when tests need to read/write credentials as part of their test work. This namespace should be used when the credentials are only needed during the execution of a single test. Various test cases may write to this namespace, so no assumptions should be made about what it contains.
    
    static let storageNamespaceForJunkCredentials = NSUUID(UUIDString: "FE083FA9-79CB-4D61-9E12-9BD609C9743B")!

    
    /// The bundle ID is used (along with namespaces) to make storage keys unique on a per-app basis (because different apps may make use of this SDK).
    
    static var bundleId: String {
        return NSBundle.mainBundle().bundleIdentifier ?? "missing-bundle-id"
    }

    
    /// Get a fully-qualified storage identifier based on `identifier`. If `namespace` and `appIdentifier` are not supplied, the default storage namespace and app `bundleIdentifier` are used, which suffices for most purposes.
    
    static func buildNamespacedIdentifier(identifier: String, namespace: NSUUID? = nil, appIdentifier: String? = nil) ->  String {
        
        let appIdentifier   = appIdentifier ?? SoracomCredentials.bundleId
        let namespaceString = (namespace ?? defaultStorageNamespace).UUIDString

        return "\(identifier).\(appIdentifier).\(namespaceString)"
    }
    
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
            return "SoracomCredentials.Default.\(self.rawValue)"
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
