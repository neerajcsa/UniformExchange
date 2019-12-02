//
//  MenuTableCell.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 29/11/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class MenuTableCell: UITableViewCell {

    // MARK: - Properties
    @IBOutlet weak var otlMenuName : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
