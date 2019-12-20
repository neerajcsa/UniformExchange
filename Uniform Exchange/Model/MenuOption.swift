//
//  MenuOption.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 01/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible, CaseIterable {

    case MyOrders
    case MyAddresses
    case ReferAFriend
    case ReturnPolicy
    case ShippingPolicy
    case Settings
    case CustomerSupport
    
    var description: String {
        switch self {
        case .MyOrders: return "My Orders"
        case .MyAddresses: return "My Addresses"
        case .ReferAFriend: return "Refer a Friend"
        case .ReturnPolicy: return "Return Policy"
        case .ShippingPolicy: return "Shipping Policy"
        case .Settings: return "Settings"
        case .CustomerSupport: return "Customer Support"
        }
    }
    
}

