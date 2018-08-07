// DO NOT EDIT; THIS CODE IS AUTOMATICALLY GENERATED AND WILL BE PERIODICALLY OVERWRITTEN.
// Generated on behalf of Kludge-O-Matic via swaggen

import Foundation

extension Response where T == VerifyEmailChangeTokenRequest {

    public func parse() -> T? {

        guard let data = data else {
            return nil
        }

        return try? JSONDecoder().decode(VerifyEmailChangeTokenRequest.self, from: data)
    }

}
