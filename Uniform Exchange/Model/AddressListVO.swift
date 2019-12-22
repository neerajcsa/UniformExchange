//
//  AddressListVO.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 22/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

struct AddressListVO : Codable {
    var success : String?
    var email : String?
    
    struct Address : Codable {
        var id : String?
        var mobile : String?
        var country : String?
        var zipcode : String?
        var isshipping : String?
        var isbilling : String?
        var name : String?
        var state : String?
        var street : [String]?
        var city : String?
    }

    var result : [Address]
}
