//
//  AddressTableCell.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 22/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class AddressTableCell: UITableViewCell {
    
    //MARK:- Properties
    @IBOutlet weak var otlContainerView : UIView?
    @IBOutlet weak var otlLblName : UILabel?
    @IBOutlet weak var otlLblStreetAndCity : UILabel?
    @IBOutlet weak var otlLblCountry : UILabel?
    @IBOutlet weak var otlLblMobileNumber : UILabel?
    @IBOutlet weak var otlBtnEdit : UIButton?
    @IBOutlet weak var otlBtnRemove : UIButton?
    
    weak var addressVC : AddressViewController?

    var address : AddressListVO.Address! {
        didSet {
            self.otlLblName?.text = self.address.name ?? ""
            self.otlLblStreetAndCity?.text = self.getFullAddress()
            self.otlLblCountry?.text = self.getFullCountry()
            self.otlLblMobileNumber?.text = String(format: "Phone number : %@", self.address.mobile ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //set border
        self.otlContainerView?.backgroundColor = UIColor.white
        self.otlContainerView?.layer.borderColor = UIColor.label.cgColor
        self.otlContainerView?.layer.borderWidth = 0.5
//        self.otlContainerView?.layer.cornerRadius = 8
        self.otlContainerView?.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- Method Declaration
    
    @IBAction func onBtnClickEdit(sender : UIButton) {
        
    }
    
    @IBAction func onBtnClickRemove(sender : UIButton) {
        
    }
    
    func getFullAddress() -> String {
        var fullAddress = ""
        fullAddress = self.address.street?.joined(separator: ", ") ?? ""
        fullAddress = fullAddress + ", " + (self.address.city ?? "")
        return fullAddress
    }
    
    func getFullCountry() -> String {
        var fullCountry = ""
        fullCountry = (self.address.state ?? "") + ", " + self.countryName(from: self.address.country ?? "")
        fullCountry = fullCountry + " - " + (self.address.zipcode ?? "")
        return fullCountry
    }
    
    func countryName(from countryCode: String) -> String {
        if let name = (Locale.current as NSLocale).displayName(forKey: .countryCode, value: countryCode) {
            // Country name was found
            return name
        } else {
            // Country name cannot be found
            return countryCode
        }
    }

}
