// SimpleMenu.swift Created by mason on 2018/02/10. 

import Foundation

/**
    Simple kludgey little CLI menu mechanism.
 */
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
    
    
    /**
     Run menu interactively, until user enters a valid choice, then returns the `value` of the chosen item.
     */
    public func run() -> String {
        
        var options = InputReaderOptions()
        options.prohibit = CharacterSet.init(charactersIn: "0987654321").inverted
        
        while true {
            
            printMenu()
            
            let result = InputReader(options: options).getInput()
            
            switch result {
            
            case .success(let input):
                // It validated, but we have our own bit of additional validation to do:
                guard let chosenItem = Int(input) else {
                    print("🤷‍♀️   Sorry, '\(input)' doesn't seem to be a number. Please try again:")
                    continue
                }
                let itemIndex = chosenItem - 1 // human readable → 0-based index
                
                guard itemIndex < items.count && itemIndex >= 0 else {
                    print("🤷‍♀️   Sorry, there is no item \(input) available. Please try again:")
                    continue
                }
                
                return items[itemIndex].value

            case .failure(let badInput, let errorMessage):
                print("🤷‍♀️   Hmm, couldn't grok '\(badInput)': \(errorMessage)")
                print("🤷‍♀️   Please try again.")
            }
        }
    }
    
    
    public func printMenu() {
        
        print("")
        print("")
        print("🔢   MENU — Enter a number to choose:")
        print("")
        
        var menuChoice = 1;
        
        for item in items {
            
            print("\(menuChoice)) \(item.description)")
            menuChoice += 1;
        }
    }
    
}


public struct SimpleMenuItem {
    let value: String
    let description: String
}
