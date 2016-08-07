// Swaggerer.swift Created by mason on 2016-08-05. Copyright © 2016 Soracom, Inc. All rights reserved.

import Foundation

class Swaggerer {
    
    let options: [String:String]
    
    var pathToSwaggerCodegen = "/usr/local/bin/swagger-codegen" // could be option someday
    
    
    init(options: [String:String] = [:]) {
        self.options = options
    }
    
    
    var workingDirectory: String {
        
        return path(identifier: kWorkingDirectory) {
            FileManager().currentDirectoryPath
        }
    }
    
    
    var inputFile: String {
        
        return path(identifier: kInputFile) {
            "/Users/mason/Code/ios-client/Dependencies/soracom-sdk-swift/Whatever/CodeGeneratorForSoracomSDKSwift/soracom-api.en.json" // hehe
        }
    }
    
    
    var intermediateDirectory: String {
        
        return path(identifier: kWorkingDirectory) {
            (NSTemporaryDirectory() as NSString).appendingPathComponent("swaggerer-\(UUID().uuidString)")
        }
    }
    
    
    var outputDirectory: String {
        
        return path(identifier: kOutputDirectory) {
            (self.workingDirectory as NSString).appendingPathComponent("generated-source-code")
        }
    }
    
    
    var swaggererVersion: String {
        return "0.0d1"
    }
    
    
    func path(identifier: String, builder: ()->String) -> String {
        
        if let existing = options[identifier] {
            return existing
        } else if let existing = defaultDirectories[identifier] {
            return existing
        } else {
            let built = builder()
            defaultDirectories[identifier] = built
            return built
        }
    }
    
    
    private var defaultDirectories: [String:String] = [:]
    
    
    func run() {
        
        Swift.print("")
        print("SWAGGERER \(swaggererVersion) is running with these options:")
        print("")
        print("\(kWorkingDirectory): \(workingDirectory)")
        print("")
        print("\(kInputFile): \(inputFile)")
        print("")
        print("\(kIntermediateDirectory): \(intermediateDirectory)")
        print("")
        print("\(kOutputDirectory): \(outputDirectory)")
        print("")
        
        if swagger() {
            print("Code generation completed successfully.")
        } else {
            print("Code generation failed.")
        }
        
        print("")
        print("以上")
    }
    
    
    func swagger() -> Bool {
        
        guard swaggerIsAccessible() else {
            print("ERROR: The swagger-codegen command is not accessible.")
            print("You may need to run: brew install swagger-codegen")
            return false;
        }
        
        guard runSwaggerCommand() else {
            print("ERROR: The swagger-codegen command reported an error.")
            print("The output above may have clues pertaining to how this can be solved.")
            return false;
        }
        
        return true
    }
    
    
    func swaggerIsAccessible() -> Bool {
        return FileManager().isExecutableFile(atPath: pathToSwaggerCodegen)
    }
    
    
    func runSwaggerCommand() -> Bool {
        // swagger-codegen generate -i api-definition/soracom-api.en.json -l swift -o test-bro -t swagger-templates
        
        let templatesDir = "/Users/mason/Code/ios-client/Dependencies/soracom-sdk-swift/Whatever/CodeGeneratorForSoracomSDKSwift/swagger-templates-for-soracom-sdk-swift" // temporary, obviously...

        let swag = TaskWrapper(pathToSwaggerCodegen, arguments: ["generate", "-i", inputFile, "-l", "swift", "-o", outputDirectory, "-t", templatesDir])

        swag.launch()
        
        // print("stderr:")
        // print(swag.stderrText)
        
        // print("stdout:")
        // print(swag.stdoutText)
        
        return swag.terminationStatus == 0
    }
    
    
    func print(_ message: Any) {
        Swift.print(">>> \(message)")
    }
 
    
    let kWorkingDirectory      = "--working-directory"
    let kInputFile             = "--input-file"
    let kIntermediateDirectory = "--intermediate-directory"
    let kOutputDirectory       = "--output-directory"
}
