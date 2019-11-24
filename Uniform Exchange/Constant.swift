//
//  Constant.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 21/01/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

struct Application {
    static let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate

    typealias ServiceClosure = (Data?,URLResponse?,Error?)->Void
    typealias UploadServiceClosure = (Bool,Int,AnyObject)->Void
    
    static let specialCharacter : String = "~!@#$%^&*()_+{}|:\"\"<>?/.,';\\][=-"
}

struct Service {
    //Login
    
    //Public
    static let timeoutInterval : TimeInterval = 120
    
}

struct NetworkErrorMessage {
    static let networkNotAvailable : String = "Network is not available. Please try again after some time."
    static let networkHostNotFound : String = "Network host not reachable. Please try again after some time."
    static let networkTimeOut : String = "Request times out. Please try again after some time."
    static let serverError : String = "Server error has occured. Please try again after some time."
}


