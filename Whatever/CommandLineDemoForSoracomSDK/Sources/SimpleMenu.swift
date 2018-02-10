// SimpleMenu.swift Created by mason on 2018/02/10. 

import Foundation

public struct SimpleMenuItem {
    let value: String
    let description: String
}


public class SimpleMenu: ExpressibleByDictionaryLiteral {
    
    public typealias Key   = String
    public typealias Value = String
    
    var items: [SimpleMenuItem] = []
    
    required public init() {
    }

    public convenience required init(dictionaryLiteral elements: (String, String)...) {
        
        self.init()
        for (value, description) in elements {
            let newItem = SimpleMenuItem(value: value, description: description)
            items.append(newItem)
        }
    }
    
    
    /// Run menu interactively, until user enters a valid choice, then returns the `value` of the chosen item.
    
    public func run() -> String {
        
        print("")
        print("MENU — Enter a number to choose:")
        print("")
        
        var menuChoice = 1;
        
        for item in items {
            
            print("\(menuChoice)) \(item.description)")
            menuChoice += 1;
        }
        print("\n> ", terminator: "")
        
        let allowedCharacters    = CharacterSet.init(charactersIn: "0987654321")
        let disallowedCharacters = allowedCharacters.inverted
        
        guard let input = readLine()?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else {
            print("Sorry, you need to make a choice. Please try again:")
            return run()
        }
        
        if input == "" {
            print("Sorry, you need to make a choice. Please try again:")
            return run()
        }
        
        if input.rangeOfCharacter(from: disallowedCharacters) != nil {
            print("Sorry, '\(input)' is not a valid choice. Please try again:")
            return run()
        }
        
        guard let chosenItem = Int(input) else {
            print("Sorry, '\(input)' doesn't seem to be a number. Please try again:")
            return run()
        }
        
        let itemIndex = chosenItem - 1 // human readable → 0-based index
        
        guard itemIndex < items.count && itemIndex >= 0 else {
            print("Sorry, there is no item \(input) available. Please try again:")
            return run()
        }
        
        return items[itemIndex].value
    }

}
