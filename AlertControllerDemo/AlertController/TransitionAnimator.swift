//
//  TransitionAnimator.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit


enum TransitionAnimate : Int {
    case present
    case dismiss
}

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionAnimate :TransitionAnimate
    
    init(transitionAnimate: TransitionAnimate) {
        self.transitionAnimate = transitionAnimate
        super.init()
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        
        return AnimationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        switch transitionAnimate {
        case .present:
            presentTransition(transitionContext)
            break
        default:
            dismissTransition(transitionContext)
            break
        }
        
        
    }
    
    func presentTransition(transitionContext: UIViewControllerContextTransitioning?) {
        
        let toView = transitionContext?.viewForKey(UITransitionContextToViewKey)
        
        toView?.alpha = 0
        
        
        transitionContext?.containerView()!.addSubview(toView!)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { 
            
            toView?.alpha = 1
            }) { (_) in
                
                transitionContext?.completeTransition(true)
        }
        
        
        
        
    }
    
    func dismissTransition(transitionContext: UIViewControllerContextTransitioning?) {
        
        let fromView = transitionContext?.viewForKey(UITransitionContextFromViewKey)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
            
            fromView?.alpha = 0
        }) { (_) in
            
            
            fromView?.removeFromSuperview()
            transitionContext?.completeTransition(true)
        }
        
        
    }
    

}
