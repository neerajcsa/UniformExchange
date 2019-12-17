//
//  MenuOption.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 01/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    
    case ReferAFriend
    case Settings
    case CustomerSupport
    
    var description: String {
        switch self {
        case .ReferAFriend: return "Refer a Friend"
        case .Settings: return "Settings"
        case .CustomerSupport: return "Customer Support"
        }
    }
    
}

