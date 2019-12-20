//
//  RegisterUserViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 08/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftKeychainWrapper

class RegisterUserViewController: UIViewController,UITextFieldDelegate {
    
    //MARK:- Properties
    
    @IBOutlet weak var otlTextFirstName : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextLastName : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextEmail : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextPassword : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextConfirmPassword : SkyFloatingLabelTextField?
    @IBOutlet weak var otlBtnRegister : UIButton?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Register"
        navigationController?.navigationBar.topItem?.title = ""
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
    
    //MARK:- Action method
    
    @IBAction func onBtnClickRegister(_ sender : UIButton) {
        //first name
        let firstName = self.otlTextFirstName?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard firstName.count > 0 else {
            return
        }
        //last name
        let lastName = self.otlTextLastName?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard lastName.count > 0 else {
            return
        }
        //email
        let email = self.otlTextEmail?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard email.count > 0 && isValidEmailAddress(emailAddress: email) else {
            Application.appDelegate.showNotification(message: "Please enter valid e-mail address.", style: .warning)
            return
        }
        //password
        let password = self.otlTextPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard password.count > 0 else {
            return
        }
        //confirm password
        let confirmPassword = self.otlTextConfirmPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard confirmPassword.count > 0 else {
            return
        }
        
        guard password == confirmPassword else {
            return
        }
        
        //call service to get register
        self.callServiceToRegister(firstName: firstName, lastName: lastName, eMail: email, password: password)
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
    
    func callServiceToRegister(firstName : String, lastName : String, eMail : String, password : String) {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //create request
        let registerURL : URL? = URL(string : String(format: "%@%@&firstname=%@&lastname=%@&email=%@&password=%@", Application.appDelegate.strServerURL ?? "",Service.registerUser, firstName, lastName, eMail, password))

        let genericService = GenericService()
        genericService.getRequestForService(getURL: registerURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
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
                        let customerId = dictionary["customerid"] as? String ?? ""
                        let customerName = firstName + " " + lastName
                        DispatchQueue.main.async {
                            //set logged in
                            Application.appDelegate.isLoggedIn = true
                            
                            //set customer name and Id into keychain
                            KeychainWrapper.standard.set(customerId, forKey: "CUSTOMER_ID")
                            KeychainWrapper.standard.set(customerName, forKey: "CUSTOMER_NAME")
                            KeychainWrapper.standard.set(Application.appDelegate.isLoggedIn, forKey: "LOGGED_IN")
                            
                            Application.appDelegate.showNotification(message: "Successfully registered.", style: .danger)
                            //Pop view controller to account view
                            self?.navigationController?.popViewController(animated: true)
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
    
    //MARK:- UITextFieldDelegate method
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
    {
        switch textField.tag {
        case 10:
            self.otlTextFirstName?.errorMessage = ""
        case 11:
            self.otlTextLastName?.errorMessage = ""
        case 12:
            self.otlTextEmail?.errorMessage = ""
        case 13:
            self.otlTextPassword?.errorMessage = ""
        case 14:
            self.otlTextConfirmPassword?.errorMessage = ""
        default:
            break
        }
        
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    {
        switch textField.tag {
        case 10:
            if textField.text?.count == 0 {
                self.otlTextFirstName?.errorMessage = "Enter First Name"
            }
        case 11:
            if textField.text?.count == 0 {
                self.otlTextLastName?.errorMessage = "Enter Last Name"
            }
        case 12:
            if textField.text?.count == 0 {
                self.otlTextEmail?.errorMessage = "Enter E-mail"
            }
        case 13:
            if textField.text?.count == 0 {
                self.otlTextPassword?.errorMessage = "Enter Password"
            }
        case 14:
            if textField.text?.count == 0 {
                self.otlTextConfirmPassword?.errorMessage = "Enter Confirm Password"
            }
        default:
            break
        }
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        let length = (textField.text?.count)! - range.length + string.count
        if length < 0 || length > 50 {
            return false
        }
        switch textField.tag {
        case 10:
             break
        case 11:
            break
        case 12:
            break
        case 13:
            break
        case 14:
            break
        default:
            break
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        switch textField.tag {
        case 10:
            break
        case 11:
            break
        case 12:
            break
        case 13:
            break
        case 14:
            break
        default:
            break
        }
        
        return true
    }

}
