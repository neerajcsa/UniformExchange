//
//  RegisterUserViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 08/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

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
        //last name
        let lastName = self.otlTextLastName?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        //email
        let email = self.otlTextEmail?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        //password
        let password = self.otlTextPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        //confirm password
        let confirmPassword = self.otlTextConfirmPassword?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        guard password == confirmPassword else {
            return
        }
        
        //call service to get register
        self.callServiceToRegister(firstName: firstName, lastName: lastName, eMail: email, password: password)
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
            
            print(String.init(data: data!, encoding: .utf8) as Any)
            
            if statusCode == 200 {
                
            } else {
                
            }
        }
    }
    
    //MARK:- UITextFieldDelegate method
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
    {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) // if implemented, called in place of textFieldDidEndEditing:
    {
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        return true
    }

}
