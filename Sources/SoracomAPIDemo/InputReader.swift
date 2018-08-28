// InputReader.swift Created by mason on 2018/02/10.

import Foundation


/**
    A simple class to read CLI input.
 */
open class InputReader {

    public var options: InputReaderOptions = InputReaderOptions()

    public init(options: InputReaderOptions = InputReaderOptions()) {

        self.options = options
    }


    /**
        Convenience method to read user input (loops until input is valid).
     */
    open func getInputUntilValid(message: String? = nil) -> String {

        if let message = message {
            print("")
            print(message)
        }
        let result = getInput()
        switch result {
        case .success(let input):
            return input
        case .failure(_, let errorMessage):
            print("")
            print("Hmm, input invalid: \(errorMessage)")
            print("Please try again.")
            return getInputUntilValid()
        }
    }


    /**
     Canonical read method for user input. Returns an `InputReaderResult` value; either `.success` or else `.failure`.
     */
    open func getInput(options: InputReaderOptions? = nil) -> InputReaderResult {

        let opts = options ?? self.options

        if let prompt = opts.prompt {
            print(prompt, terminator: "")
        }

        var input = readLine(strippingNewline: opts.stripNewline) ?? ""

        if let trim = opts.trim {
            input = input.trimmingCharacters(in: trim)
        }
        if let prohibit = opts.prohibit {

            if let invalidRange = input.rangeOfCharacter(from: prohibit) {
                return .failure(input, "contains invalid character(s) ('\(input[invalidRange])')")
            }
        }

        guard opts.minLength < 1 || input.count >= opts.minLength else {
            return .failure(input, "too short (must be at least \(opts.minLength) characters)")
        }
        guard opts.maxLength >= input.count else {
            return .failure(input, "too long (\(opts.maxLength) characters is the maximum allowed)")
        }
        return .success(input)
    }

}


public struct InputReaderOptions {

    var minLength               = 1
    var maxLength               = 65_535
    var stripNewline            = true
    var prohibit: CharacterSet? = nil
    var trim: CharacterSet?     = CharacterSet.whitespacesAndNewlines
    var prompt: String?         = "> "

    // could add validator func here if ever needed...

    /// `init()` does nothing, but its presence is required to avoid making it internal

    public init() {}
}


public enum InputReaderResult {

    ///  Represents success. The associated string is the input, after any processing (e.g. trimming)

    case success(String)

    /// Represents failure due to invalid input. The associated strings are the input, after any processing (e.g. trimming, stripping newline, etc), and a short error message sentence fragement such as ("exceeds allowed length of 21 characters").

    case failure(String, String)
}
