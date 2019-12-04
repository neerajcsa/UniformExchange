//
//  CustomPresentationManager.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 04/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

enum PresentationDirection {
    case left
    case top
    case right
    case bottom
}
enum PresentationType {
    case textfield
    case popover
    case textarea
}

class CustomPresentationManager: NSObject {

    //MARK: - Property Declaration
    var direction = PresentationDirection.bottom
    var type = PresentationType.textfield
}

extension CustomPresentationManager : UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController,  presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = CustomPresentationController(presentedViewController: presented, presenting: presenting, direction: direction, type : type)
        return presentationController
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CustomPresentationAnimator(direction: direction, type : type, isPresentation: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            return CustomPresentationAnimator(direction: direction, type : type, isPresentation: false)
    }
    
}
