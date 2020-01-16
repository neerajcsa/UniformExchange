//
//  ProductCategoryVC.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 05/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

struct ProductCategoryVC : Codable {
    var success : String
    
    struct Category : Codable {
        var pid : String
        var name : String
        var image : String
    }

    var category : [Category]
}

struct ProductListVC : Codable {
    var success : String
    
    var products : [GridProducts]
}
