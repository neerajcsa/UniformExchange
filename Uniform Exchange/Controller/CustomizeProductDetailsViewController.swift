//
//  CustomizeProductDetailsViewController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 13/01/20.
//  Copyright © 2020 Neeraj Pandey. All rights reserved.
//

import UIKit

class CustomizeProductDetailsViewController: UIViewController {

    //MARK:- Properties Declaration
    
    @IBOutlet weak var otlImgProductDetails : UIImageView?
    @IBOutlet weak var otlLblProductPrice : UILabel?
    @IBOutlet weak var otlLblProductName : UILabel?
    @IBOutlet weak var otlImgProductThumbnail1 : UIImageView?
    @IBOutlet weak var otlImgProductThumbnail2 : UIImageView?
    //for shirt
    @IBOutlet weak var otlLblShirtTitle : UILabel?
    @IBOutlet weak var otlBtnXS : UIButton?
    @IBOutlet weak var otlBtnS : UIButton?
    @IBOutlet weak var otlBtnM : UIButton?
    @IBOutlet weak var otlBtnL : UIButton?
    @IBOutlet weak var otlBtnXL : UIButton?
    @IBOutlet weak var otlBtnXXL : UIButton?
    @IBOutlet weak var otlLblShirtQuantityTitle : UILabel?
    @IBOutlet weak var otlBtnShirtQuantityValue : UIButton?
    @IBOutlet weak var otlBtnShirtIncrement : UIButton?
    @IBOutlet weak var otlBtnShirtDecrement : UIButton?
    
    //for pant
    @IBOutlet weak var otlLblPantTitle : UILabel?
    @IBOutlet weak var otlBtn28 : UIButton?
    @IBOutlet weak var otlBtn30 : UIButton?
    @IBOutlet weak var otlBtn32 : UIButton?
    @IBOutlet weak var otlBtn34 : UIButton?
    @IBOutlet weak var otlBtn36 : UIButton?
    @IBOutlet weak var otlBtn38 : UIButton?
    @IBOutlet weak var otlLblPantQuantityTitle : UILabel?
    @IBOutlet weak var otlBtnPantQuantityValue : UIButton?
    @IBOutlet weak var otlBtnPantIncrement : UIButton?
    @IBOutlet weak var otlBtnPantDecrement : UIButton?
    
    @IBOutlet weak var otlBtnAddToCart : UIButton?
    
    var productDetails : GridProducts?
    var shirtQuantity : Int = 1
    var pantQuantity : Int = 1
    
    let MAX_QUANTITY_VALUE = 100
    let MIN_QUANTITY_VALUE = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //set appearance
        self.setControlAppearance()
        
        //configure product details
        self.configureProductDetails()
        
        //set default shirt size and pant size
        self.onBtnClickShirtSize(sender: self.otlBtnS!)
        self.onBtnClickPantSize(sender: self.otlBtn30!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configure navigation bar
        self.configureNavigationBar()
    }

    func configureNavigationBar() {
        //set title
        navigationItem.title = "Poduct Details"
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setControlAppearance() {
        //thumbnails corner
        self.otlImgProductThumbnail1?.layer.borderColor = UIColor.red.cgColor
        self.otlImgProductThumbnail1?.layer.borderWidth = 1.0
        self.otlImgProductThumbnail2?.layer.borderColor = UIColor.red.cgColor
        self.otlImgProductThumbnail2?.layer.borderWidth = 1.0
        
        //shirt
        self.otlBtnS?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnS?.layer.borderWidth = 1.0
        self.otlBtnM?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnM?.layer.borderWidth = 1.0
        self.otlBtnL?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnL?.layer.borderWidth = 1.0
        self.otlBtnXS?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnXS?.layer.borderWidth = 1.0
        self.otlBtnXL?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnXL?.layer.borderWidth = 1.0
        self.otlBtnXXL?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtnXXL?.layer.borderWidth = 1.0
        
        //pant
        self.otlBtn28?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn28?.layer.borderWidth = 1.0
        self.otlBtn30?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn30?.layer.borderWidth = 1.0
        self.otlBtn32?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn32?.layer.borderWidth = 1.0
        self.otlBtn34?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn34?.layer.borderWidth = 1.0
        self.otlBtn36?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn36?.layer.borderWidth = 1.0
        self.otlBtn38?.layer.borderColor = UIColor.quaternaryLabel.cgColor
        self.otlBtn38?.layer.borderWidth = 1.0
    }
    
    func configureProductDetails() {
        //get the download url
        let downloadString = self.productDetails?.image ?? ""
        self.otlImgProductThumbnail1?.sd_setImage(with: URL(string: downloadString), placeholderImage: nil, options: .continueInBackground, context: nil)
        //set image
        self.otlImgProductDetails?.image = self.otlImgProductThumbnail1?.image
        //product detail && product price
        let productName = self.productDetails?.name ?? "-"
        let productPrice = self.productDetails?.price ?? 0
        
        self.otlLblProductName?.text = productName
        self.otlLblProductPrice?.text = "₹ \(productPrice)/-"
        
        //set shirt and pant quantity
        self.otlBtnShirtQuantityValue?.setTitle("\(shirtQuantity)", for: .normal)
        self.otlBtnPantQuantityValue?.setTitle("\(pantQuantity)", for: .normal)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK:- Action Method
    
    @IBAction func onBtnClickShirtSize(sender : UIButton) {
        //select size
        self.otlBtnXS?.layer.borderColor = self.otlBtnXS?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnXS?.setTitleColor(self.otlBtnXS?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtnS?.layer.borderColor = self.otlBtnS?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnS?.setTitleColor(self.otlBtnS?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtnM?.layer.borderColor = self.otlBtnM?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnM?.setTitleColor(self.otlBtnM?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtnL?.layer.borderColor = self.otlBtnL?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnL?.setTitleColor(self.otlBtnL?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtnXL?.layer.borderColor = self.otlBtnXL?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnXL?.setTitleColor(self.otlBtnXL?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtnXXL?.layer.borderColor = self.otlBtnXXL?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtnXXL?.setTitleColor(self.otlBtnXXL?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
    }
    
    @IBAction func onBtnClickPantSize(sender : UIButton) {
        //select size
        self.otlBtn28?.layer.borderColor = self.otlBtn28?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn28?.setTitleColor(self.otlBtn28?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtn30?.layer.borderColor = self.otlBtn30?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn30?.setTitleColor(self.otlBtn30?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtn32?.layer.borderColor = self.otlBtn32?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn32?.setTitleColor(self.otlBtn32?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtn34?.layer.borderColor = self.otlBtn34?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn34?.setTitleColor(self.otlBtn34?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtn36?.layer.borderColor = self.otlBtn36?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn36?.setTitleColor(self.otlBtn36?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
        
        self.otlBtn38?.layer.borderColor = self.otlBtn38?.tag == sender.tag ? UIColor.label.cgColor : UIColor.quaternaryLabel.cgColor
        self.otlBtn38?.setTitleColor(self.otlBtn38?.tag == sender.tag ? UIColor.label : UIColor.quaternaryLabel, for: .normal)
    }
    
    @IBAction func onBtnClickShirtQuantityIncrement(sender : UIButton) {
        guard shirtQuantity < MAX_QUANTITY_VALUE else {
            Application.appDelegate.showNotification(message: "Reached max value.", style: .warning)
            return
        }
        
        shirtQuantity += 1
        self.otlBtnShirtQuantityValue?.setTitle("\(shirtQuantity)", for: .normal)
    }
    
    @IBAction func onBtnClickShirtQuantityDecrement(sender : UIButton) {
        guard shirtQuantity > MIN_QUANTITY_VALUE else {
            Application.appDelegate.showNotification(message: "Reached min value.", style: .warning)
            return
        }
        
        shirtQuantity -= 1
        self.otlBtnShirtQuantityValue?.setTitle("\(shirtQuantity)", for: .normal)
    }
    
    @IBAction func onBtnClickPantQuantityIncrement(sender : UIButton) {
        guard pantQuantity < MAX_QUANTITY_VALUE else {
            Application.appDelegate.showNotification(message: "Reached max value.", style: .warning)
            return
        }
        
        pantQuantity += 1
        self.otlBtnPantQuantityValue?.setTitle("\(pantQuantity)", for: .normal)
    }
    
    @IBAction func onBtnClickPantQuantityDecrement(sender : UIButton) {
        guard pantQuantity > MIN_QUANTITY_VALUE else {
            Application.appDelegate.showNotification(message: "Reached min value.", style: .warning)
            return
        }
        
        pantQuantity -= 1
        self.otlBtnPantQuantityValue?.setTitle("\(pantQuantity)", for: .normal)
    }
    
    @IBAction func onBtnClickAddToCart(sender : UIButton) {
        
    }

}
