//
//  ProductCategoryCollectionCell.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 05/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class ProductCategoryCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var otlImageView : UIImageView?
    @IBOutlet weak var otlCircularView : UIView?
    @IBOutlet weak var otlLblName : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //cell rounded corners
        self.otlCircularView?.layer.cornerRadius = (self.otlCircularView?.frame.size.width ?? 100)/2
        self.otlCircularView?.layer.masksToBounds = true
        
        self.otlImageView?.layer.cornerRadius = (self.otlImageView?.frame.size.width ?? 100)/2
        self.otlImageView?.layer.masksToBounds = true
        self.otlImageView?.clipsToBounds = true
        self.otlImageView?.image = UIImage(named: "taxi_dress")
//        self.otlImageView?.layer.borderWidth = 3.0
//        self.otlImageView?.layer.borderColor = UIColor.red.cgColor

    }
    
}
