//
//  GlobalConfig.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 21/01/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class GlobalConfig: NSObject {

    static let sharedInstance = GlobalConfig()
    var dicPathConfig : Dictionary<String,AnyObject>?
    
    //MARK: - Read Path Config
    
    class func setConfigDataFromPathConfig() {
        //get the path of the plist file
        guard let plistPath = Bundle.main.path(forResource: "PathConfig", ofType: "plist") else { return }
        //load the plist as data in memory
        guard let plistData = FileManager.default.contents(atPath: plistPath) else { return }
        //use the format of a property list (xml)
        var format = PropertyListSerialization.PropertyListFormat.xml
        //convert the plist data to a Swift Dictionary
        guard let  plistDict = try! PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as? [String : AnyObject] else { return }
        
        GlobalConfig.sharedInstance.dicPathConfig = plistDict
    }
    
    class func printLog(message: String, function: String = #function) {
        #if DEBUG
        print("\(function): \(message)")
        #endif
    }
    
    func printLog(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        Swift.print(items[0], separator:separator, terminator: terminator)
    }
    
}


//https://speedbraker.com/pub/api.php?apirequest=dashboard
//https://speedbraker.com/pub/api.php?apirequest=productlist
//https://speedbraker.com/pub/api.php?apirequest=productdetail&prid=1155

//Register API
//https://speedbraker.com/pub/api.php?apirequest=doregister&firstname=Sun&lastname=java&email=sun@gmail.com&password=@password&street=test1&street1=test2&postcode=201301&telephone=9876543221&city=Noida&state=Utter Pradesh
//Update password
//https://speedbraker.com/pub/api.php?apirequest=updatepassword&email=sun@gmail.com&password=@password1
//Forgot Password
 //https://speedbraker.com/pub/api.php?apirequest=resetpassword&email=sunil.chawla145@gmail.com
//Get All Address
//https://speedbraker.com/pub/api.php?apirequest=getaddress&customerId=53
//Login API
//https://speedbraker.com/pub/api.php?apirequest=login&email=sun@gmail.com&password=@password1
//New Shipping Address
//https://speedbraker.com/pub/api.php?apirequest=newshippingaddress&firstname=Sun&lastname=java&customerId=53&password=@pass&street=test1&street1=test2&postcode=201301&telephone=9876543221&city=Noida&state=Utter Pradesh
//New Billing Address
//https://speedbraker.com/pub/api.php?apirequest=newbillingaddress&firstname=Sun&lastname=java&customerId=53&password=@pass&street=test1&street1=test2&postcode=201301&telephone=9876543221&city=Noida&state=Utter Pradesh
//Default Address
//https://speedbraker.com/pub/api.php?apirequest=newdefaultaddress&firstname=Sun&lastname=java&customerId=53&password=@pass&street=test1&street1=test2&postcode=201301&telephone=9876543221&city=Noida&state=Utter Pradesh
//Address Delete
//https://speedbraker.com/pub/api.php?apirequest=removeaddress&addressId=17
//Category
//https://speedbraker.com/pub/api.php?apirequest=catlist
