//
//  HomeCollectionCell.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 20/10/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class HomeCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var otlImageView : UIImageView?
    @IBOutlet weak var otlLblProductName : UILabel?
    @IBOutlet weak var otlLblProductPrice : UILabel?
}

class HomeCollectionBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var otlImageView : UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
