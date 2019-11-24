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
