//
//  ProductListDetailsViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 26/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class ProductListDetailsViewController: UIViewController {

    //MARK:- Properties
    
    @IBOutlet weak var otlImgProduct : UIImageView?
    @IBOutlet weak var otlBtnCustomizeAddToCart : UIButton?
    @IBOutlet weak var otlLblProductName : UILabel?
    @IBOutlet weak var otlLblProductPrice : UILabel?
    
    var gridProductDetails : GridProducts?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //configure product details
        self.configureProductDetails()
    }
    
    func configureNavigationBar() {
        //set title
        navigationItem.title = "Product Details"
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configure navigation bar
        self.configureNavigationBar()
    }

    func configureProductDetails() {
        //get the download url
        let downloadString = self.gridProductDetails?.image ?? ""
        self.otlImgProduct?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        //product detail && product price
        let productName = self.gridProductDetails?.name ?? "-"
        let productPrice = self.gridProductDetails?.price ?? 0
        
        self.otlLblProductName?.text = productName
        self.otlLblProductPrice?.text = "₹ \(productPrice)/-"
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "PRODUCT_LIST_DETAILS_ID" {
            let customizeProductVC : CustomizeProductDetailsViewController = segue.destination as! CustomizeProductDetailsViewController
            customizeProductVC.productDetails = sender as? GridProducts
        }
    }
    
    
    //MARK:- Action method
    
    @IBAction func onBtnClickCustomizeAndAddToCart(sender : UIButton) {
        self.performSegue(withIdentifier: "PRODUCT_LIST_DETAILS_ID", sender: self.gridProductDetails)
    }

}
