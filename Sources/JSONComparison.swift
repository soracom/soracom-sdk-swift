// JSONComparison.swift Created by mason on 2017-07-29. Copyright © 2017 Soracom, Inc. All rights reserved.

import Foundation

/**
Provides a (limited) facility to compare objects (check equivalence) by inspecting their JSON representations. It uses JSONSerialization to rehydrate simple object graphs from JSON (data, or string), and then compares the objects in the graphs for equivalence. This approach makes it easy to ignore key order and whitespace in the JSON, It is "limited" because it doesn't yet support all possible number formats (in fact, just numbers that can be expressed by the platform's Int so far(!), see `areEquivalentJSONValues()` for details) and it hasn't yet been tested against diverse sets of JSON sample data.   
*/
open class JSONComparison {
    
    /**
     Returns true if `leftData` and `rightData` are both valid JSON data and are logically equivalent, ignoring whitespace and key order.  NOTE: Support for number values is limited; see `areEquivalentJSONValues()` for details.
    */
    open static func areEquivalent(_ leftData: Data, _ rightData: Data) -> Bool {
        guard let leftObject  = try? JSONSerialization.jsonObject(with: leftData, options: []),
              let rightObject = try? JSONSerialization.jsonObject(with: rightData, options: [])
        else {
                print("Warning: invalid JSON passed to JSONComparison.areEquivalent(_: _:)")
                return false
        }
        return areEquivalentJSONValues(leftObject, rightObject)
    }
    
    
    /**
     Returns true if `leftData` and `rightData` are both valid JSON strings and are logically equivalent, ignoring whitespace and key order. NOTE: Support for number values is limited; see `areEquivalentJSONValues()` for details.
     */    
    open static func areEquivalent(_ leftString: String, _ rightString: String) -> Bool {
        guard let leftData = leftString.data(using: .utf8),
              let rightData = rightString.data(using: .utf8)
        else {
                print("Warning: invalid (non-UTF8) JSON string passed to JSONComparison.areEquivalent(_: _:)")
                return false
        }
        return areEquivalent(leftData, rightData)
    }
 
    
    /**
    A *limited* JSON comparison for equivalence. Supports only booleans, integers expressible by Int, strings, arrays, and objects. (Arrays and objects may only contain these five types.) The main reason for that is there hasn't been time to compare how JSONEncoding, on which this is based, handles non-int numbers on Linux vs macOS/iOS.
    */
    open static func areEquivalentJSONValues(_ lhs: Any?, _ rhs: Any?) -> Bool {
        
        if lhs == nil || rhs == nil {
        
            return true;
            
        } else if let _ = lhs as? NSNull, let _ = rhs as? NSNull {
            
            return true
            // Hmm (T_T) this is a pretty weird one! Took some debuggery to figure out...
            // Depending on the whitespace in the file and the phase of the moon, when parsing 
            // something like "{foo: null}", JSONSerialization would return different things for 
            // the "null" value. The above check is the only way I was able to reliable compare them.
            //
            //    (lldb) po lv
            //    <null>
            //    (lldb) po rv
            //        ▿ Optional<Any>
            //    (lldb) po type(of: lv)
            //    NSNull
            //    (lldb) po type(of: rv)
            //    Swift.Optional<Any>
            
        } else if let leftDictionary = lhs as? [String:Any], let rightDictionary = rhs as? [String:Any] {
            
            for (k,lv) in leftDictionary {
                let rv = rightDictionary[k]
                if !areEquivalentJSONValues(lv, rv) {
                    return false
                }
            }
            for (k,rv) in rightDictionary {
                let lv = leftDictionary[k]
                if !areEquivalentJSONValues(rv, lv) {
                    return false
                }
            }
            return true
            
        } else if let leftArray = lhs as? [Any], let rightArray = rhs as? [Any] {
            
            if leftArray.count != rightArray.count {
                return false
            }
            for (leftElement, rightElement) in zip(leftArray, rightArray) {
                if !areEquivalentJSONValues(leftElement, rightElement) {
                    return false
                }
            }
            return true
            
        } else if let leftString = lhs as? String, let rightString = rhs as? String {
            
            return leftString == rightString
            
        } else if let leftInt = lhs as? Int, let rightInt = rhs as? Int {
            
            return leftInt == rightInt
            
        } else if let leftBool = lhs as? Bool, let rightBool = rhs as? Bool {
            
            return leftBool == rightBool
            
        } else {
            
            return false;
        }
    }

}
