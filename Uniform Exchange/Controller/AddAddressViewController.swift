//
//  AddAddressViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 15/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddAddressViewController: UIViewController,UITextFieldDelegate {

    //MARK:- Properties
    @IBOutlet weak var otlBtnSelectCountry : UIButton?
    @IBOutlet weak var otlBtnSelectState : UIButton?
    @IBOutlet weak var otlBtnSelectAddressType : UIButton?
    @IBOutlet weak var otlBtnAddAddress : UIButton?
    @IBOutlet weak var otlTextFullName : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextLandmark : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextMobileNumber : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextZipcode : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextHouseAddress : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextStreetAddress : SkyFloatingLabelTextField?
    @IBOutlet weak var otlTextCity : SkyFloatingLabelTextField?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    
    var isEditAddress : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //configure
        self.configureControlAppearance()
        
        self.otlBtnSelectCountry?.setTitle("India", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isEditAddress {
            navigationItem.title = "Edit Address"
        } else {
            navigationItem.title = "Add Address"
        }
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func configureControlAppearance() {
        //set button border
        self.otlBtnSelectCountry?.layer.borderWidth = 0.5
        self.otlBtnSelectCountry?.layer.borderColor = UIColor.label.cgColor
        
        self.otlBtnSelectState?.layer.borderWidth = 0.5
        self.otlBtnSelectState?.layer.borderColor = UIColor.label.cgColor
        
        self.otlBtnSelectAddressType?.layer.borderWidth = 0.5
        self.otlBtnSelectAddressType?.layer.borderColor = UIColor.label.cgColor
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
    
    @IBAction func onBtnClickSelectState(sender : UIButton) {
        
    }
    
    @IBAction func onBtnClickSelectAddressType(sender : UIButton) {
        
    }
    
    @IBAction func onBtnClickAddAddress(sender : UIButton) {
        
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
    
    func callServiceToAddAddress(firstName : String, lastName : String, eMail : String, password : String) {
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
                        DispatchQueue.main.async {
                            
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
        case 100:
            break
        case 101:
            break
        case 102:
            break
        case 103:
            break
        case 104:
            break
        case 105:
            break
        case 106:
            break
        default:
            break
        }
        
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    {
        switch textField.tag {
        case 100:
            if textField.text?.count == 0 {
                
            }
        case 101:
            if textField.text?.count == 0 {
                
            }
        case 102:
            if textField.text?.count == 0 {
                
            }
        case 103:
            if textField.text?.count == 0 {
                
            }
        case 104:
            if textField.text?.count == 0 {
                
            }
        case 105:
            if textField.text?.count == 0 {
                
            }
        case 106:
            if textField.text?.count == 0 {
                
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
        case 100:
             break
        case 101:
            break
        case 102:
            break
        case 103:
            break
        case 104:
            break
        case 105:
            break
        case 106:
            break
        default:
            break
        }
        
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        switch textField.tag {
        case 100:
            break
        case 101:
            break
        case 102:
            break
        case 103:
            break
        case 104:
            break
        case 105:
            break
        case 106:
            break
        default:
            break
        }
        
        return true
    }
    
}
