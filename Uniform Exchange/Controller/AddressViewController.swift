//
//  AddressViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 15/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class AddressViewController: UIViewController {

    //MARK:- Properties
    @IBOutlet weak var otlTableView : UITableView?
    @IBOutlet weak var otlBtnAddAddress : UIButton?
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?
    
    var addressListVO : AddressListVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //set table view height
        self.otlTableView?.rowHeight = UITableView.automaticDimension
        self.otlTableView?.estimatedRowHeight = 200
        
        //set button border
        self.otlBtnAddAddress?.layer.borderWidth = 0.5
        self.otlBtnAddAddress?.layer.borderColor = UIColor.label.cgColor
        
        //call service to get all address
        //get customer id
        let customerId = KeychainWrapper.standard.string(forKey: "CUSTOMER_ID")
        self.callServiceToGetAddress(customerId: customerId ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "My Addressess"
        navigationController?.navigationBar.topItem?.title = ""
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
    
    @IBAction func onBtnClickAddAddress(sender : UIButton) {
        self.performSegue(withIdentifier: "ADD_EDIT_ADDRESS_ID", sender: self)
    }
    
    func onBtnClickEditAddress() {
        self.performSegue(withIdentifier: "ADD_EDIT_ADDRESS_ID", sender: self)
    }
    
    func onBtnClickRemoveAddress() {
        
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
    
    func callServiceToGetAddress(customerId : String) {
        //Start animation
        self.manageProgressView(isHidden: true)
        //create request
        let addressURL : URL? = URL(string : String(format: "%@%@&customerId=%@", Application.appDelegate.strServerURL ?? "",Service.getAddress, customerId))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: addressURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode

            if error != nil {
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                }
                return
            }
            
            guard data != nil else {
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                }
                return
            }
            
            if statusCode == 200 {
                let decoder = JSONDecoder()
                do {
                    self?.addressListVO = try decoder.decode(AddressListVO.self, from: data!)
                    if self?.addressListVO?.success == "true" {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            //reload table view
                            self?.otlTableView?.reloadData()
                        }
                    } else {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            Application.appDelegate.showNotification(message: NetworkErrorMessage.serverError, style: .danger)
                        }
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        //stop animation
                        self?.manageProgressView(isHidden: false)
                        Application.appDelegate.showNotification(message: error.localizedDescription, style: .danger)
                    }
                }
            } else {//could not convert to dictionary
                DispatchQueue.main.async {
                    //stop animation
                    self?.manageProgressView(isHidden: false)
                    Application.appDelegate.showNotification(message: NetworkErrorMessage.serverError, style: .danger)
                }
            }
        }
    }

}

extension AddressViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.addressListVO?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : AddressTableCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "ADDRESS_TABLE_CELL_ID", for: indexPath) as? AddressTableCell
        
        //configure table cell
        self.configureAddressTableCell(cell: cell!, indexPath: indexPath)
        
        return cell!
    }
    
    func configureAddressTableCell(cell : AddressTableCell, indexPath : IndexPath) {
        let address = addressListVO?.result[indexPath.section]
        
        //assign controller
        cell.addressVC = self
        
        //set address
        cell.address = address
    }

}
