//
//  AppDelegate.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 24/11/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var strAppName : String?
    var strServerURL : String?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Call Config Method
        GlobalConfig.setConfigDataFromPathConfig()
        
        //set app config
        self.setAppConfig()
        
        return true
    }
    
    //MARK: - Read Path Config
    
    func setAppConfig() {
        //access the values in the dictionary
        strAppName = GlobalConfig.sharedInstance.dicPathConfig?["App-Name"] as? String ?? ""
        strServerURL = GlobalConfig.sharedInstance.dicPathConfig?["Server-Config"]!["Server-URL"] as? String ?? ""
    }


    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    
    //MARK:- Encode characters for special characters
    
    func encodeJsonDataWithValues(jsonData : Data) -> Data {
        let jsonString : String = String.init(data: jsonData, encoding: .utf8) ?? ""
        //convert into special characters
        let convertedJsonString = jsonString.convertSpecialCharacter()
        
        let convertedJSONData = (convertedJsonString?.data(using: .utf8))!
        
        var jsonData : Data = "values=".data(using: String.Encoding.utf8)!
        //Append data
        jsonData.append(convertedJSONData)
        
        return jsonData
    }
    
    func encodeJsonData(jsonData : Data) -> Data {
        let jsonString : String = String.init(data: jsonData, encoding: .utf8) ?? ""
        //convert into special characters
        let convertedJsonString = jsonString.convertSpecialCharacter()
        
        let convertedJSONData = (convertedJsonString?.data(using: .utf8))!
        
        return convertedJSONData
    }
    
    //MARK: Date Utilities method
    
    func getStringDatefromTimeStamp (strDate : String , fromDateFormat : String, toDateFormat: String) -> String {
        let trimmedDate = strDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromDateFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = dateFormatter.date(from: trimmedDate)
        dateFormatter.dateFormat = toDateFormat
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        
        let formattedDateString = date != nil ? dateFormatter.string(from: date!) : strDate
        return formattedDateString
    }
    
    func getDatefromTimeStamp (strDate : String) -> Date? {
        let trimmedDate = strDate.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = _T_DATE_FORMAT
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let formattedDate = dateFormatter.date(from: trimmedDate)
        return formattedDate
    }
    
    func formatDateToString(date : Date, format : String) -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let formattedString : String = dateFormatter.string(from: date)
        return formattedString
    }
    
    func formatStringToDate(date : String, format : String) -> Date? {
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
        let formattedDate : Date? = dateFormatter.date(from: date)
        return formattedDate
    }
    
    //MARK: - attributed string
    
    func attributedStringForLabelTitle(title : String) -> NSAttributedString {
        let attributeTitle : NSMutableAttributedString = NSMutableAttributedString(string: "\(title)*")
        attributeTitle.addAttribute(NSAttributedString.Key.foregroundColor, value: _NAVIGATION_BAR_BACKGROUND_COLOR, range: NSMakeRange(attributeTitle.length - 1, 1))
        return attributeTitle
    }

}

