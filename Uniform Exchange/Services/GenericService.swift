//
//  GenericService.swift
//  LoloAndBebo
//
//  Created by Neeraj Pandey on 21/01/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import Foundation

class GenericService: NSObject {
    
    //MARK : Get Service
    
    func getRequestForService(getURL : URL, httpMethod : String, serviceClosure : @escaping Application.ServiceClosure) -> Void {
        //create url request
        var request : URLRequest = URLRequest(url: getURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Service.timeoutInterval)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = true
        
        //set request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create default session
        let session = URLSession.shared
        
        //make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            serviceClosure(data, response, error)
        }
        //resume task
        task.resume()
    }
    
    //MARK : Put Service
    
    func putRequestForService(putURL : URL, httpMethod : String, serviceClosure : @escaping Application.ServiceClosure) -> Void {
        //create url request
        var request : URLRequest = URLRequest(url: putURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Service.timeoutInterval)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpShouldHandleCookies = true
        
        //create default session
        let session = URLSession.shared
        
        //make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            serviceClosure(data, response, error)
        }
        //resume task
        task.resume()
    }
    
    //MARK: - Post Request
    
    func postRequestForService(postURL : URL, httpMethod : String, jsonData : Data, isEncoded : Bool, serviceClosure : @escaping Application.ServiceClosure) -> Void {
        //create url request
        var request : URLRequest = URLRequest(url: postURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Service.timeoutInterval)
        
        request.httpMethod = httpMethod
        if !isEncoded {
            request.httpBody = jsonData
        } else {
            request.httpBody = Application.appDelegate.encodeJsonData(jsonData: jsonData)
        }
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = true
        
        request.setValue(String(format: "%u",jsonData.count), forHTTPHeaderField: "Content-Length")
        
        //set request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create default session
        let session = URLSession.shared
        
        //make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            serviceClosure(data, response, error)
        }
        //resume task
        task.resume()
    }
    
    func postRequestForServiceWithoutData(postURL : URL, httpMethod : String, serviceClosure : @escaping Application.ServiceClosure) -> Void {
        //create url request
        var request : URLRequest = URLRequest(url: postURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Service.timeoutInterval)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = true
        
        //set request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create default session
        let session = URLSession.shared
        
        //make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            serviceClosure(data, response, error)
        }
        //resume task
        task.resume()
    }
    
    func deleteRequestForService(deleteURL : URL, httpMethod : String, serviceClosure : @escaping Application.ServiceClosure) -> Void {
        //create url request
        var request : URLRequest = URLRequest(url: deleteURL, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: Service.timeoutInterval)
        
        request.httpMethod = httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpShouldHandleCookies = true
        
        //set request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //create default session
        let session = URLSession.shared
        
        //make the request
        let task = session.dataTask(with: request) { (data, response, error) in
            serviceClosure(data, response, error)
        }
        //resume task
        task.resume()
    }

}
