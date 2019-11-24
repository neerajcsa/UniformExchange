//
//  LoginService.swift
//  LoloAndBebo
//
//  Created by Neeraj Pandey on 21/01/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class LoginService: NSObject {

    //MARK : - Method Declaration/Definition
    
    //Prepare param for Login authentication
    func prepareParamForLoginAuthentication(userName : String, password : String) -> Data? {
        let trimmedUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines).convertSpecialCharacter()
        let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines).convertSpecialCharacter()
        
        let formattedString : String = String(format: "username=%@&password=%@", trimmedUserName!,trimmedPassword!)
        let encodedData : Data = formattedString.data(using: .utf8)!
        
        return encodedData
    }
    
    func getLoginAccount(loginClosure: @escaping Application.ServiceClosure) -> Void {
        let urlString : String = String.init(format: "%@", arguments: [Application.appDelegate.strServerURL ?? ""])
        
        guard let accountURL = URL(string : urlString) else {
            return
        }
        
        //send get request
        GenericService().getRequestForService(getURL: accountURL, httpMethod: "GET", isUrlEncoded: false, serviceClosure: {(data, response, error) in
            loginClosure(data, response, error)
        })
    }
    
    
    
}
