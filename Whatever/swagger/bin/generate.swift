#!/usr/bin/swift

// This script expects the swagger-codegen command to be instaled with `brew install swagger-codegen`.


import Foundation


class SwaggerRunner {
    
    let versionString   = "0.0.1"
    let releaseDate     = "2016-07-19"
    
    var lastCommand: String?
    var lastExitStatus: Int32?
    

    func run() {

        print()
        print("— Welcome to \(#file)")
        print("— version \(versionString) [\(releaseDate)]")
        print()
        
        let swaggerCommand        = "swagger-codegen"
        let pathToTemplatesDir    = "swagger-templates"
        let pathToIntermediateDir = "tmp-build-files" // git ignored
        let pathToGeneratedOutput = "build"
        let pathToAPIDefinition   = "api-definition/soracom-api.en.json"
        
        task("confirm swagger is acceptible") {
            "swagger-codegen > /dev/null"
        }
        
        task("check UUID hack to confirm we are in the right directory") {
            
            "grep 17EA6C8F-FB83-4ACF-850B-226AA89D85C5 .directory-uuid > /dev/null"
        
            // A dirty hack, since Swift doesn't have many conveniences to introspect about the running script.
            // We only allow running in a directory containing a .directory-uuid file containing that string.
            // That way we never accidentally run in the wrong place, thereby writing/deleting the wrong files.
        }
        
        task("run swagger to generate code from API spec") {
            
            "swagger-codegen generate -i \(pathToAPIDefinition) -l swift -o \(pathToIntermediateDir) -t \(pathToTemplatesDir) "
        }
        
        task("copy the required subset of the auto-generated files") {
            
            "oops-this-doesnt-work-yet-so-lets-crash-the-program-here"
        }
        
    }
    
    
    @noreturn func die(message: String? = nil, details: String? = nil) {
        
        var formattedOutput = message ?? "UNSPECIFIED FATAL ERROR"
        if let details = details {
            formattedOutput += "\n\n\(details)"
        }
        if let status = lastExitStatus, let cmd = lastCommand {
            formattedOutput += "\n\nLast command (exited with status \(status)): \(cmd)"
        }
        formattedOutput += "\n\n"
        
        fatalError(formattedOutput)
    }
    
    
    func task(description: String, closure: (()->String)) {
        
        let cmd = closure()
        
        print()
        print("— NEXT STEP: \(description)")
        print("— Shell command: \(cmd)")
        print()
        
        lastCommand    = cmd
        lastExitStatus = system(cmd)
        
        let result = (lastExitStatus == 0)
        
        guard result else {
            die("FAILED: \(description)")
        }
    }
}


let runner = SwaggerRunner()
runner.run()
