//
//  CartVO.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 19/01/20.
//  Copyright © 2020 Neeraj Pandey. All rights reserved.
//

import UIKit

struct CartVO : Codable {
    var success : String?
    var coupon : String?
    var cartid : String?
    var total : Double?
    
    struct Result : Codable {
        var pid : String?
        var name : String?
        var qty : Int?
        var image : String?
        var sku : String?
        var price : Double?
        var itemid : String?
        var size : String?
    }
    
    var result : [Result]
}
