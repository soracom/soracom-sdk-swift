// Strings.swift Created by mason on 2018/02/10.

import Foundation

struct Strings {
    
    public static let welcome = """
        

                              ,   ,:+#@@@@#*:.   ,
                           *SORACOMSORACOMSORACOMSORA.
                      .SORACOMSORACOMSORACOMSORACOMSORACO@
                   *SORACOMSO#,                   :SORACOMSOR,
                ,SORACOMS:                             @SORACOM#
              ,SORACOMSORACOMSORA#:,                      #SORACO@
             SORACOM+@SORACOMSORACOMSORACOM@*.   ,          :SORACO+
           .SORACO            :#SORACOMSORACOMSORACOMS#:,     *SORACO
          +SORAC#                       ,+@SORACOMSORACO#       SORACO
         .SORAC*                              ,    SORAC#        SORACO
         SORAC@                                    SORAC#        ,SORAC+
        :SORAC,                                    SORAC#         @SORAC
        #SORAC                                  :#SORACO#         :SORAC
        @SORAC                   ,   .+@SORACOMSORACOMSO#         :SORAC
        *SORAC            ,:#SORACOMSORACOMSORACOMS#:,            *SORAC
        ,SORAC*        SORACOMSORACOMSOR@*,                       SORAC@
         #SORAC,        @SORAC@.                                 #SORAC
          SORACO,        +SORAC@                   /*:          #SORAC:
           SORACO+        ,SORACO               +** . **`.      SORACO.
            *SORACO         SORACO,               /* *\\      #SORACO
              SORACOM.       SORACO+      @SO+             @SORACO+
                SORACOMS      *SORAC#  #SORACOM#        +SORACOM*
                  #SORACOMS@, ,.SORACOMSORACO       :SORACOMSO,,
                     #SORACOMSORACOMSORACO  ,:#SORACOMSORAC,
                         *SORACOMSORACOMSORACOMSORACOMS.
                              ,+@SORACOMSORACOMS#.

                     ⭐︎ COMMAND-LINE DEMO FOR SORACOM SDK ⭐︎

        Welcome to CommandLineDemoForSoracomSDK, a simple example program
        to demonstrate how to use this SDK to interact with the SORACOM API
        from Swift code. This program requires a command-line environment and
        Swift 4.1. It should work on both Linux and macOS.
        """
    
    public static let noCredentialsExist = """
        There are currently no valid stored credentials for an API Sandbox user.

        To create a new user in the API Sandbox, you will need to enter real
        credentials for a SAM user in the real (production) environment.
        
        This program will then authenticate using those real credentials, and
        will then create a user in the API Sandbox environment. The sandbox
        user will then be used to use to demonstrate some ways to use this SDK
        to interact with the SORACOM API.
        """

    public static let pleaseEnterProductionAuthKeyID = """
        Please enter the 'authKeyId' for a production SAM user:
        """
    
    public static let pleaseEnterProductionAuthKeySecret = """
        Please enter the 'authKeySecret' for a production SAM user:
        """
    
    
    
    
}
