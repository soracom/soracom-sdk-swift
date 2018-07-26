// CredentialsModel.swift Created by Mason Mark on 2018-07-25. Copyright © 2018 Soracom, Inc. All rights reserved.

import Foundation

/// This structure is the full credential object that is returned by the API server upon a successful `listCredentials()` or `createCredential()` request.
///
/// **NOTE:** `CredentialsModel` objects returned by the API server contain a `CredentialsModel` structure, but that structure does not include the `secretAccessKey` value.

public class CredentialsModel: _CredentialsModel {


    // The base implementation for this class is provided by the
    // auto-generated superclass (_CredentialsModel).
    //
    // A lot of code for things like API structures can be generated
    // automatically from the API specification. Using this "generation
    // gap" pattern gives us a simple way to have human-edited code for
    // code documentation and special cases, without having to take extra
    // steps when the code is regenerated.
}

extension CredentialsModel {
    
    /// A convenience initializer mainly for automated tests.
    
    convenience init(description: String) {
        self.init()
        self.description = description
    }
}
