//
//  CartTableCell.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 19/01/20.
//  Copyright © 2020 Neeraj Pandey. All rights reserved.
//

import UIKit

class CartTableCell: UITableViewCell {

    //MARK:- Properties
    
    @IBOutlet weak var otlImgProduct : UIImageView?
    @IBOutlet weak var otlLblProductName : UILabel?
    @IBOutlet weak var otlLblProductSize : UILabel?
    @IBOutlet weak var otlLblProductPrice : UILabel?
    @IBOutlet weak var otlBtnClose : UIButton?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        //configure control apprance
        self.configureControlAppearance()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureControlAppearance() {
        self.otlLblProductName?.textColor = UIColor.label
        self.otlLblProductSize?.textColor = UIColor.label
        self.otlLblProductPrice?.textColor = UIColor.secondaryLabel
    }
    
}
