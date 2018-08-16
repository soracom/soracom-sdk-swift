import Foundation

extension Response {

    open func parse() -> T? {

        guard let data = data else {

            if T.self == NoResponseBody.self {
                // This is a special case. A nil data is expected.
                return NoResponseBody() as? T
            }
            return nil
        }

        var result: T? = nil

        let d = JSONDecoder()

        do {
            if T.self == NoResponseBody.self {
                // Not sure if/how to make this work: return try d.decode(NoResponseBody.self, from: data) as? T
                return NoResponseBody() as? T

// ------------------- PUT AUTOGEN HERE:
