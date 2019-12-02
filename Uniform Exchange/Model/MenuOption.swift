//
//  MenuOption.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 01/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case Home
    case ShopByCategory
    case YourOrder
    case YourAccounts
    case ReferAFriend
    case Settings
    case CustomerSupport
    
    var description: String {
        switch self {
        case .Home: return "Home"
        case .ShopByCategory: return "Shop By Category"
        case .YourOrder: return "Your Order"
        case .YourAccounts: return "Your Account"
        case .ReferAFriend: return "Refer a Friend"
        case .Settings: return "Settings"
        case .CustomerSupport: return "Customer Support"
        }
    }
    
}

