//
//  ViewController.swift
//  HQShowDetailAlertView
//
//  Created by Hunter on 2020/6/13.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .custom
        alertViewController.transitioningDelegate = self
        
        present(alertViewController, animated: true, completion: nil)
    }
    
}
extension ViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CustomPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropDownAnimatedTransition(isPresent: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DropDownAnimatedTransition(isPresent: false)
    }
}
