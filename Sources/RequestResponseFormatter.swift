// RequestResponseFormatter.swift Created by mason on 2016-04-26. Copyright © 2016 masonmark.com. All rights reserved.

import Foundation


/// Simple object that can render Request and Response instances in human-readable format, suitable for logging and debugging.

public class RequestResponseFormatter {
    
    /// A type propery that serves as a global value that controls whether sensitive information like passwords and keys are redacted in `description` (which may be used by logging functions). By default this is `true` but apps that want to print or log Request and Response instances without masking sensitive information may set this to `false`.
    
    public static var shouldRedact = true
    
    
    /// The instance value of `shouldRedact` has precedence. If not set, then the value of the `shouldRedact` type property will be used.
    
    public var shouldRedact: Bool {
        
        get {
            if let instanceValue = _shouldRedact {
                return instanceValue
            } else {
                return type(of: self).shouldRedact
            }
        }
        
        set {
            _shouldRedact = newValue
        }
    }
    private var _shouldRedact: Bool? = nil
    
    
    /// Return the key and value, redacting if necessary.
    
    func format(_ key: String, value: String, redact: Bool = shouldRedact) -> (key: String, value: String) {
        
        let sensitiveKeys = ["token", "authKey", "password", "X-Soracom-Token", "X-Soracom-API-Key"]

        return (redact && sensitiveKeys.contains(key)) ? (key: key, value: "<REDACTED>") : (key: key, value: value)
    }

    
    /// Format a Request instance in human-readable form.
    
    public func formatRequest(_ request: Request) -> String {
        
        let typeName = type(of: request)
        
        var result = ""
        
        result += "\(typeName) \(request.requestId) {"
        
        result    += "\n  \(request.method) \(request.buildURL())"
        
        if let urlReq = request.URLRequest {
            result += "\n  HTTP headers: {"
            
            if let fields = urlReq.allHTTPHeaderFields {
                for (k, v) in fields {
                    let formatted = format(k, value: v)
                    result += "\n    \(formatted.key): \(formatted.value)"
                }
                if fields.count > 0 {
                    result += "\n  "
                }
            }
        }
        result += "}"
        
        let pretty = prettifyJSON(request.payload?.toJSON())
        
        result += "\n  HTTP body (payload): \(pretty)"
        
        result += "\n}"
        
        return result
    }
    
    // FIXME: the code needs a bit of cleanup, and unify whether the \n is at beginning or end, FFS!
    
    /// Format a Response instance in human-readable form.
    
    public func formatResponse(_ response: Response) -> String {
        let typeName = type(of: response)
        
        var result = ""
        
        result += "\(typeName) \(response.request.requestId) {\n"
        
        if let status = response.HTTPStatus {
            result += "  HTTP status:  \(status)\n"
        }
        
        result += "  HTTP headers: {"
        
        if let underlyingURLResponse = response.underlyingURLResponse {
            
            let fields = underlyingURLResponse.allHeaderFields
            
            for (k,v) in fields {
                let formatted = format("\(k)", value: "\(v)")
                result += "\n    \(formatted.key): \(formatted.value)"
            }
            
            if fields.count > 0 {
                result += "\n  "
            }
            result += "}\n"
        }
        
        let pretty = prettifyJSON(response.text)
        result += "  HTTP body (payload): \(pretty)\n"
        
        result += "}"
        
        return result
    }
    
    
    /// A brutal kludge to prettify JSON, specific to the way Request and Response `description` strings are formatted.
    
    public func prettifyJSON(_ text: String?) -> String {
        
        guard let text = text else {
            return "{}"
        }
        
        guard text != "" else {
            return "{}"
        }
        
        var result = text
        do {
            if let data = text.data(using: String.Encoding.utf8) {
                
                let obj = try JSONSerialization.jsonObject(with: data, options: [])
                
                var redacted = obj as? [String:Any]
                
                if redacted != nil && shouldRedact {
                    let sensitiveKeys = ["token", "authKey", "password"]
                    for k in sensitiveKeys {
                        if let _ = redacted![k] {
                            redacted![k] = "<REDACTED>"
                        }
                    }
                }
                let newData = try JSONSerialization.data(withJSONObject: redacted ?? obj, options: [.prettyPrinted])
                
                if let pretty = String(data: newData, encoding: String.Encoding.utf8) {
                    let lines = pretty.components(separatedBy: "\n")
                    let linesToIndent = lines[0..<(lines.count - 1)]
                    let indented = linesToIndent.joined(separator: "\n    ")
                    result = indented + "\n  \(lines.last ?? "🆖")"
                }
            }
        } catch {
            print("Note: error prettifying JSON: \(text)")
        }
        return result
    }

}
