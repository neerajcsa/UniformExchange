//
//  HomeVC.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 20/10/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

struct HomeVC: Codable {
    var success : String
    
    struct GridProducts : Codable {
        var pid : String
        var name : String
        var image : String
        var sku : String
        var price : Int
    }

    var sliderimages : [[String]]
    var gridproducts : [GridProducts]
}


 
