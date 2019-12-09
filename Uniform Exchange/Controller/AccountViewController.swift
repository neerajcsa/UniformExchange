//
//  AccountViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 02/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

var attrs = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14.0),NSAttributedString.Key.foregroundColor : UIColor.label,NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

class AccountViewController: UIViewController {

    //MARK:- Properties Declaration
    
    @IBOutlet weak var otlBtnSignIn : UIButton?
    @IBOutlet weak var otlBtnCreateAccount : UIButton?
    @IBOutlet weak var otlBtnForgotPassword : UIButton?
    @IBOutlet weak var otlLblEmail : SkyFloatingLabelTextField?
    @IBOutlet weak var otlLblPassword : SkyFloatingLabelTextField?
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
        
        navigationItem.title = "Account"
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

    //MARK:- Action methods
    
    @IBAction func onBtnClickSignIn(_ sender : UIButton) {
        //start animation
        self.manageProgressView(isHidden: true)
        
        //call service to login
        self.callServiceToLogin(userName: "sun1@gmail.com", password: "@password1")
    }
    
    @IBAction func onBtnClickCreateAccount(_ sender : UIButton) {
        self.performSegue(withIdentifier: "REGISTER_USER_ID", sender: self)
    }
    
    @IBAction func onBtnClickForgotPassword(_ sender : UIButton) {
        self.performSegue(withIdentifier: "FORGOT_PASSWORD_ID", sender: self)
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
}
