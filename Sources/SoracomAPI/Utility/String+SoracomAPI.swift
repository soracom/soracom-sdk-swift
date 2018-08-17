// String+SoracomAPI.swift Created by Mason Mark on 2018-08-16.

import Foundation

extension String {
    
    var snakeCased: String {
        var newString: String = ""
        let upperCase = CharacterSet.uppercaseLetters
        for scalar in self.unicodeScalars {
            if upperCase.contains(scalar) {
                if newString.count > 0 {
                    newString.append("_")
                }
                let character = Character(scalar)
                newString.append(String(character).lowercased())
            } else {
                let character = Character(scalar)
                newString.append(character)
            }
        }
        return newString
    }
}
