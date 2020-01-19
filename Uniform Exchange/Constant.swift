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
    static let login = "/pub/api.php?apirequest=login"
    //Register
    static let registerUser = "/pub/api.php?apirequest=doregister"
    static let updatePassword = "/pub/api.php?apirequest=updatepassword"
    static let forgotPassword = "/pub/api.php?apirequest=resetpassword"
    static let getAddress = "/pub/api.php?apirequest=getaddress"
    static let shippingAddress = "/pub/api.php?apirequest=newshippingaddress"
    static let billingAddress = "/pub/api.php?apirequest=newbillingaddress"
    static let defaultAddress = "/pub/api.php?apirequest=newdefaultaddress"
    static let deleteAddress = "/pub/api.php?apirequest=removeaddress"
    //Dashboard
    static let dashboard = "/pub/api.php?apirequest=dashboard"
    static let categoryList = "/pub/api.php?apirequest=catlist"
    static let productList = "/pub/api.php?apirequest=productlist"
    static let productDetails = "/pub/api.php?apirequest=productdetail&prid=%@"
    //Cart
    static let cartDetails = "/pub/api.php?apirequest=docartdetail&customerId=53"
    
    //Public
    static let timeoutInterval : TimeInterval = 120
    
}

struct NetworkErrorMessage {
    static let networkNotAvailable : String = "Network is not available. Please try again after some time."
    static let networkHostNotFound : String = "Network host not reachable. Please try again after some time."
    static let networkTimeOut : String = "Request times out. Please try again after some time."
    static let serverError : String = "Server error has occured. Please try again after some time."
}


