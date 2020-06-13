//
//  DropDownAnimatedTransition.swift
//  HQShowDetailAlertView
//
//  Created by Hunter on 2020/6/13.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit

open class DropDownAnimatedTransition: NSObject {
    /// true present  false dismiss
    public let isPresent:Bool
    
    required public init(isPresent:Bool){
        self.isPresent = isPresent
        super.init()
    }
    
    /// present 自定义下落动画实现
    func presentAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let to = transitionContext.viewController(forKey: .to) else { return }
        
        let containerView = transitionContext.containerView
        to.view.frame = to.presentationController!.frameOfPresentedViewInContainerView
        containerView.addSubview(to.view)
        to.view.transform = CGAffineTransform(translationX: 0.0, y: -to.view.frame.maxY)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.65, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            to.view.transform = CGAffineTransform.identity
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    /// dismiss 自定义消失动画实现
    func dismissAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let from = transitionContext.viewController(forKey: .from) else { return }
        UIView.animate(withDuration: 0.25, delay: 0.0, options:.curveEaseInOut, animations: {
            from.view.layer.opacity = 0.0
            from.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension DropDownAnimatedTransition:UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return isPresent ? 0.5 : 0.25
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            presentAnimateTransition(using: transitionContext)
        }else {
            dismissAnimateTransition(using: transitionContext)
        }
    }
}

