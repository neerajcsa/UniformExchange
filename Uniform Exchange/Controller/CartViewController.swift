//
//  CartViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 19/01/20.
//  Copyright © 2020 Neeraj Pandey. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {
    
    //MARK:- Properties
    
    @IBOutlet weak var otlTableView : UITableView?
    @IBOutlet weak var otlLblTotalProductsTitle : UILabel?
    @IBOutlet weak var otlLblTotalProductsValue : UILabel?
    @IBOutlet weak var otlLblShippingChargesTitle : UILabel?
    @IBOutlet weak var otlLblShippingChargesValue : UILabel?
    @IBOutlet weak var otlLblNumberOfItemsTitle : UILabel?
    @IBOutlet weak var otlLblNumberOfItemsValue : UILabel?
    @IBOutlet weak var otlBtnContinue : UIButton?
    @IBOutlet weak var otlViewContainer : UIView?
    
    @IBOutlet weak var otlProgressView : UIActivityIndicatorView?

    var cartDetails : CartVO?
    var totalProduct : Int = 0
    var shippingCharges : Int = 0
    var totalItemPrice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //start progress
        self.manageProgressView(isHidden: true)
        //call service
        self.callServiceToGetCartDetails()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configure navigation bar
        self.configureNavigationBar()
    }
    
    func configureNavigationBar() {
        //set title
        navigationItem.title = "Shopping Basket"
        //navigationController?.navigationBar.topItem?.title = ""
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
    
    @IBAction func onBtnClickContinue(sender : UIButton) {
        
    }

    //MARK:- Manage Progress View
    
    func manageProgressView(isHidden : Bool) {
        if isHidden {
             //start animation
            self.otlProgressView?.startAnimating()
            self.otlViewContainer?.isHidden = true
        } else {
            //stop animation
            self.otlProgressView?.stopAnimating()
            self.otlViewContainer?.isHidden = false
        }
        self.view.isUserInteractionEnabled = !isHidden
    }
    
    //MARK:- Service Request
    
    func callServiceToGetCartDetails() {
        //create request
        let cartURL : URL? = URL(string : String(format: "%@%@", Application.appDelegate.strServerURL ?? "",Service.cartDetails))
        let genericService = GenericService()
        genericService.getRequestForService(getURL: cartURL!, httpMethod: "GET") { [weak self] (data, response, error) in
            
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
                let decoder = JSONDecoder()
                do {
                    self?.cartDetails = try decoder.decode(CartVO.self, from: data!)
                    if self?.cartDetails?.success == "true" {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                            //reload collection
                            self?.otlTableView?.reloadData()
                            //calculate charges for items
                            self?.calculateChargesForCart()
                        }
                    } else {
                        DispatchQueue.main.async {
                            //stop animation
                            self?.manageProgressView(isHidden: false)
                        }
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        //stop animation
                        self?.manageProgressView(isHidden: false)
                    }
                    print("failed to decode json \(error.localizedDescription)")
                }
            } else {
                DispatchQueue.main.async {
                    Application.appDelegate.showNotification(message: NetworkErrorMessage.serverError, style: .danger)
                }
            }
        }
    }
    
    func calculateChargesForCart() {
        let results = self.cartDetails?.result ?? []
        var totalProductCost = 0.0
        var totalItemsCount = 0
        for result in results {
            totalProductCost += result.price ?? 0.0
            totalItemsCount += 1
        }
        
        //set label
        self.otlLblTotalProductsValue?.text = "\(totalProductCost)"
        self.otlLblShippingChargesValue?.text = "Free"
        self.otlLblNumberOfItemsTitle?.text = "\(totalItemsCount) Items"
        self.otlLblNumberOfItemsValue?.text = "\(totalProductCost)"
    }
}

extension CartViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartDetails?.result.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CartTableCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "CART_TABLE_CELL_ID", for: indexPath) as? CartTableCell
        
        //configure cart cell
        self.configureCartTableCell(cell: cell!, indexPath: indexPath)
        
        return cell!
    }
    
    func configureCartTableCell(cell : CartTableCell, indexPath : IndexPath) {
        let result : CartVO.Result? = self.cartDetails?.result[indexPath.row]
        
        //set image
        let downloadString = result?.image ?? ""
        cell.otlImgProduct?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        
        //product detail && product price
        let productName = result?.name ?? "-"
        cell.otlLblProductName?.text = productName
        let productSize = result?.size ?? "-"
        cell.otlLblProductSize?.text = productSize
        let productQty = result?.qty ?? 0
        let productPrice = result?.price ?? 0.0
        cell.otlLblProductPrice?.text = "\(Double(productQty) * productPrice) INR"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
}
