//
//  CustomPresentationController.swift
//  HQShowDetailAlertView
//
//  Created by Hunter on 2020/6/13.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit

class CustomPresentationController: UIPresentationController {
    
    var overlay: UIView!
    
    override func presentationTransitionWillBegin() {
        let containerView = self.containerView!
        
        overlay = UIView(frame: containerView.frame)
        
        overlay.gestureRecognizers = [UITapGestureRecognizer(target: self, action: #selector(CustomPresentationController.overlayDidTouch(_:)))]
        overlay.backgroundColor = .lightGray
        overlay.alpha = 0.0
        containerView.insertSubview(self.overlay, at: 0)
        
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {[weak self] context in
            self?.overlay.alpha = 0.7
            }, completion:nil)
        
        
    }
    override func dismissalTransitionWillBegin() {
        self.presentedViewController.transitionCoordinator?.animate(alongsideTransition: { [weak self] context in
            self?.overlay.alpha = 0.0
            }, completion: nil)
    }
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed {
            self.overlay.removeFromSuperview()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        
        var presentedViewFrame = CGRect()
        let containerBounds = containerView!.bounds
        let childContentSize = size(forChildContentContainer: presentedViewController, withParentContainerSize: containerBounds.size)
        presentedViewFrame = CGRect.init(x: 100, y: 200, width: childContentSize.width - 200, height: childContentSize.height - 400)
        return presentedViewFrame
    }
    override func containerViewWillLayoutSubviews() {
        
        self.overlay.frame = containerView!.bounds
        self.presentedView?.frame = frameOfPresentedViewInContainerView
        self.presentedView?.layer.cornerRadius = 10.0
        self.presentedView?.clipsToBounds = true
    }
    
}
@objc extension CustomPresentationController {
    func overlayDidTouch(_ sender: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true, completion: nil)
    }
}
