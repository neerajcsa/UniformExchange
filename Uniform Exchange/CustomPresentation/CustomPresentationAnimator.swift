//
//  CustomPresentationAnimator.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 04/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

final class CustomPresentationAnimator: NSObject {

    //MARK: - Properties
    let direction: PresentationDirection
    let type: PresentationType
    
    let isPresentation: Bool
    
    //MARK: - Initializers

    init(direction: PresentationDirection, type: PresentationType,  isPresentation: Bool) {
        self.direction = direction
        self.type = type
        self.isPresentation = isPresentation
        
        super.init()
    }
    
}

//MARK: - UIViewControllerAnimatedTransitioning
extension CustomPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to
            : UITransitionContextViewControllerKey.from
        
        let controller = transitionContext.viewController(forKey: key)!
        
        if isPresentation {
            transitionContext.containerView.addSubview(controller.view)
        }
        
        let presentedFrame = transitionContext.finalFrame(for: controller)
        var dismissedFrame = presentedFrame
        switch direction {
        case .left:
            dismissedFrame.origin.x = -presentedFrame.width
        case .right:
            dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
        case .top:
            dismissedFrame.origin.y = -presentedFrame.height
        case .bottom:
            dismissedFrame.origin.y = transitionContext.containerView.frame.size.height
        }
        
        let initialFrame = isPresentation ? dismissedFrame : presentedFrame
        let finalFrame = isPresentation ? presentedFrame : dismissedFrame
        
        let animationDuration = transitionDuration(using: transitionContext)
        controller.view.frame = initialFrame
        UIView.animate(withDuration: animationDuration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
            controller.view.frame = finalFrame
        }, completion: {
            finished in
            transitionContext.completeTransition(true)
        })
        
    }
}
