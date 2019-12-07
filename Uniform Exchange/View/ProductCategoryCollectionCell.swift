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
    @IBOutlet weak var otlLblName : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //cell rounded corners
        self.otlImageView?.layer.cornerRadius = min(self.otlImageView?.frame.size.height ?? 200, self.otlImageView?.frame.size.width ?? 200) / 2.0
        self.otlImageView?.layer.masksToBounds = true
    }
    
}
