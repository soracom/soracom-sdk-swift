// TextReplacer.swift Created by mason on 2016-08-15. Copyright © 2016 MASON MARK (.COM). All rights reserved.

import Foundation

public class TextReplacer {
    
    /// Returns nil if successful, otherwise an array of error messages. If `filter` is `nil` (the default) then all files contained by `directory` will be processed.
    
    func replaceOccurences(of replaceeString: String, with replacementString: String, directory: URL, filter: Filter? = nil) -> [String]? {
        
        let filter = filter ?? matchAll
        
        var fileLevelErrors: [String] = []

        let fileManager = FileManager.default
        guard let dirEnumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: nil, options: [], errorHandler: nil) else {
            return ["unable to read contents of directory: \(directory)"]
        }
          // fixme: handle errors
        
        for element in dirEnumerator {
            guard let fullURL = element as? URL else {
                fileLevelErrors.append("WTF error: can't enumerate directory: \(directory)")
                break
            }
            
            do {
                guard let wellThisIsntVeryConvenient = try fileManager.attributesOfItem(atPath: fullURL.path)[FileAttributeKey.type] as? NSString else {
                    // grotesque abortion of an API...
                    fileLevelErrors.append("could not get file type: \(fullURL.path)")
                    continue
                }
                let isRegularFile = wellThisIsntVeryConvenient as String == FileAttributeType.typeRegular.rawValue
                  // putrescent rotting corpse of an API...
                guard isRegularFile else {
                    continue
                }
                
                // Whew! Now that we have navigated that horrid swamp of legacy runtime interop sewage, let's process our file!
                
                guard let original = try? String(contentsOf: fullURL) as NSString else {
                    fileLevelErrors.append("could not read file: \(fullURL.path)")
                    continue
                }
                
                guard filter(fullURL, original as String) else {
                    continue // user filter chose not to process this file
                }
                
                let modified = original.replacingOccurrences(of: replaceeString, with: replacementString)
                
                try modified.write(to: fullURL, atomically: true, encoding: .utf8)
                
            } catch {
                fileLevelErrors.append("could not replace text in file: \(error): \(fullURL.path)")
            }
        }
        return fileLevelErrors.count > 0 ? fileLevelErrors : nil
    }
    
    
    /// Returns nil if successful, otherwise an array of error messages. Only files whose path extension exactly matches an element `fileExtensions` will be processed. (Don't include the "."; pass an array like `["txt", "swift", "m", "h"]`.)
    
    func replaceOccurences(of replaceeString: String, with replacementString: String, directory: URL, extensions: [String]) -> [String]? {
        let filter = makeFilter(extensions: extensions)
        return replaceOccurences(of: replaceeString, with: replacementString, directory: directory, filter: filter)
    }


    private func makeFilter(extensions: [String]) -> Filter {
        let extensionsToProcess = extensions
        return {(file: URL, contents: String) in return extensionsToProcess.contains(file.pathExtension) }
    }
    
    public typealias Filter = ((_ file: URL, _ contents: String) -> Bool)
    
    public let matchAll: Filter = {(file: URL, contents: String) in return true }

}
