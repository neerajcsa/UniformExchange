//
//  AccountViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 02/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftKeychainWrapper

var attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor : UIColor.label,NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

class AccountViewController: UIViewController {

    //MARK:- Properties Declaration
    @IBOutlet weak var otlViewLoginContainer : UIView?
    @IBOutlet weak var otlViewTableContainer : UIView?
    @IBOutlet weak var otlBtnSignOut : UIButton?
    @IBOutlet weak var otlLblAccountName : UILabel?
    @IBOutlet weak var otlLblAccountDetails : UILabel?
    @IBOutlet weak var otlBtnSignIn : UIButton?
    @IBOutlet weak var otlBtnCreateAccount : UIButton?
    @IBOutlet weak var otlBtnForgotPassword : UIButton?
    @IBOutlet weak var otlTextEmail : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextPassword : SkyFloatingLabelTextField?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //forgot password attributed text
        let buttonTitleStr = NSMutableAttributedString(string:"Forgotten your password?", attributes:attrs)
        let attributedString = NSMutableAttributedString(string:"")
        attributedString.append(buttonTitleStr)
        otlBtnForgotPassword?.setAttributedTitle(attributedString, for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configure navigation bar
        self.configureNavigationBar()
        //configure account view
        self.configureAccountView()
        self.setAccountDetails()
    }

    func configureNavigationBar() {
        //set title
        navigationItem.title = "My Account"
    }
    
    func configureAccountView() {
        //if user logged in then display logged in details
        //hide view
        self.otlViewLoginContainer?.isHidden = Application.appDelegate.isLoggedIn
        self.otlViewTableContainer?.isHidden = !Application.appDelegate.isLoggedIn
    }
    
    func setAccountDetails() {
        if Application.appDelegate.isLoggedIn {
            let customerName = KeychainWrapper.standard.string(forKey: "CUSTOMER_NAME")
            self.otlLblAccountName?.text = "Welcome" + " " + (customerName ?? "Guest")
            self.otlLblAccountDetails?.text = ""
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK:- Action methods
    
    @IBAction func onBtnClickSignIn(_ sender : UIButton) {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //get user name
        let userName = self.otlTextEmail?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        //get password
        let password = self.otlTextPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard validateLoginFields(userName: userName, password: password) else {
            return
        }

        //call service to login
        self.callServiceToLogin(userName: userName, password: password)
    }
    
    @IBAction func onBtnClickCreateAccount(_ sender : UIButton) {
        self.performSegue(withIdentifier: "REGISTER_USER_ID", sender: self)
    }
    
    @IBAction func onBtnClickForgotPassword(_ sender : UIButton) {
        self.performSegue(withIdentifier: "FORGOT_PASSWORD_ID", sender: self)
    }
    
    @IBAction func onBtnClickSignOut(_ sender : UIButton) {
        //remove account details
        KeychainWrapper.standard.removeObject(forKey: "CUSTOMER_ID")
        KeychainWrapper.standard.removeObject(forKey: "CUSTOMER_NAME")
        KeychainWrapper.standard.removeObject(forKey: "LOGGED_IN")
        
        //set logged in flag
        Application.appDelegate.isLoggedIn = false
        //configure accoutn view
        self.configureAccountView()
    }
    
    func validateLoginFields(userName : String, password : String) -> Bool {
        guard userName.count > 0 else {
            return false
        }
        
        guard password.count > 0 else {
            return false
        }
        
        return true
    }
    
    func isValidEmailAddress(emailAddress: String) -> Bool {
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0 {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    //MARK:- Manage Progress View
    
    func manageProgressView(isHidden : Bool) {
        if isHidden {
             //start animation
            self.otlProgressView?.startAnimating()
        } else {
            //stop animation
            self.otlProgressView?.stopAnimating()
        }
        self.view.isUserInteractionEnabled = !isHidden
    }
    
    //MARK:- Service Request
    
    func callServiceToLogin(userName : String, password : String) {
        //create request
        let loginURL : URL? = URL(string : String(format: "%@%@&email=%@&password=%@", Application.appDelegate.strServerURL ?? "",Service.login, userName, password))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: loginURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            
            DispatchQueue.main.async {
                //stop animation
                self?.manageProgressView(isHidden: false)
            }
            
            if error != nil {
                return
            }
            
            guard data != nil else {
                return
            }
            
            if statusCode == 200 {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [String: Any] {
                    if let success = dictionary["success"] as? String, success == "true" {
                        //set logged in flag
                        Application.appDelegate.isLoggedIn = true
                        
                        let customerId = dictionary["customerid"] as? String
                        let customerName = dictionary["customername"] as? String
                        DispatchQueue.main.async {
                            //set customer details in keychain
                            KeychainWrapper.standard.set(customerId ?? "", forKey: "CUSTOMER_ID")
                            KeychainWrapper.standard.set(customerName ?? "", forKey: "CUSTOMER_NAME")
                            KeychainWrapper.standard.set(Application.appDelegate.isLoggedIn, forKey: "LOGGED_IN")
                            //configure account view
                            self?.configureAccountView()
                            self?.setAccountDetails()
                        }
                    } else { // failed
                        let result = dictionary["result"] as? String
                        DispatchQueue.main.async {
                            Application.appDelegate.showNotification(message: result ?? NetworkErrorMessage.serverError, style: .danger)
                        }
                    }
                } else {//could not convert to dictionary
                    DispatchQueue.main.async {
                        Application.appDelegate.showNotification(message: NetworkErrorMessage.serverError, style: .danger)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    Application.appDelegate.showNotification(message: NetworkErrorMessage.serverError, style: .danger)
                }
            }
        }
    }
}

