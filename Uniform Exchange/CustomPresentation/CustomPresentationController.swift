//
//  CustomPresentationController.swift
//  Uniform Exchange
//
//  Created by Neeraj Pandey on 04/12/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {

    // MARK: - Properties
    private var direction: PresentationDirection
    private var type: PresentationType
    fileprivate var dimmingView: UIView!
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, direction: PresentationDirection, type: PresentationType) {
        self.direction = direction
        self.type = type
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)
        
        //setup dimming view
        setupDimmingView()
    }
    
    override func presentationTransitionWillBegin() {
        
        containerView?.insertSubview(dimmingView, at: 0)
        
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "V:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(withVisualFormat: "H:|[dimmingView]|",
                                           options: [], metrics: nil, views: ["dimmingView": dimmingView]))
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .left, .right:
            return CGSize(width: parentSize.width*(2.0/3.0), height: parentSize.height)
        case .bottom, .top:
            if type == .textfield {
                return CGSize(width:parentSize.width - 10, height:CGFloat(250.0))
            } else if type == .popover {
                return CGSize(width:parentSize.width - 10, height:CGFloat((floorf(Float(parentSize.height / 2.0)))))
            } else {
                return CGSize(width:parentSize.width - 10, height:CGFloat((floorf(Float(parentSize.height / 2.0)))))
            }
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        let containerBounds = containerView?.bounds
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        
        switch direction {
        case .right:
            frame.origin.x = containerView!.frame.width*(1.0/3.0)
        case .bottom:
            if type == .textfield {
                frame.origin.y = ((containerBounds?.size.height)! - frame.size.height)/2
            } else if type == .popover {
                frame.origin.y = ((containerBounds?.size.height)! - frame.size.height)/2
            } else {
                frame.origin.y = frame.size.height - (((containerBounds?.size.height)! - frame.size.height)/2)
            }
            frame.origin.x = (containerBounds?.origin.x)! + 5
        default:
            frame.origin = .zero
        }
        return frame
    }
    
}

// MARK: - Private
private extension CustomPresentationController {
    func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    
}
