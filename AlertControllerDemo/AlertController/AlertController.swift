//
//  AlertController.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

let AnimationDuration = 0.25
let DefaultMargin: CGFloat = 10.0

enum AlertControllerStyle : Int {
    
    case ActionSheet
    case Alert
}

class AlertController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var dimBackgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.5)
 
    var contentView: UIView?
    
    var titleAttributeText: NSAttributedString?
    var messageAttributeText: NSAttributedString?
    
    var message: String?
    
    var messageColor: UIColor = UIColor(red: 150/255.0, green: 150/255.0, blue: 150/255.0, alpha: 1)
    var messageFont: UIFont = UIFont.systemFontOfSize(14)
    
    var titleColor: UIColor = UIColor(red: 31/255.0, green: 31/255.0, blue: 31/255.0, alpha: 1)
    var titleFont: UIFont = UIFont.systemFontOfSize(16)
    
    func addAction(action: AlertAction) {
        
        alertActions.append(action)
        
    }
    
    
    
    convenience init(title: String?, message: String?, contentView: UIView?, preferredStyle: AlertControllerStyle) {
        
        self.init()
        self.title = title
        self.message = message
        self.preferredStyle = preferredStyle
        self.contentView = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        dimBackgroundButton.frame = view.bounds
//    }
    
    private func setupUI() {
        
        view.backgroundColor = dimBackgroundColor
//        view.addSubview(dimBackgroundButton)
//        dimBackgroundButton.backgroundColor = dimBackgroundColor
        
        switch preferredStyle {
        case .Alert:
            
            currentDisplayView = AlertView()
            
            break
        default:
            currentDisplayView = SheetView()
            
            
            break
        }
        
        view.addSubview(currentDisplayView!)
        
        currentDisplayView!.alertActionButtonDidClick = { [unowned self] in
            
            self.dismiss()
            
        }
        
        currentDisplayView!.alertActions = alertActions
        if titleAttributeText == nil {
            currentDisplayView!.titleLabel.text = title
            currentDisplayView!.titleLabel.font = titleFont
            currentDisplayView!.titleLabel.textColor = titleColor
        }else {
            currentDisplayView!.titleLabel.attributedText = titleAttributeText
        }
        
        if messageAttributeText == nil {
            
            currentDisplayView!.messageLabel.text = message
            currentDisplayView!.messageLabel.font = messageFont
            currentDisplayView!.messageLabel.textColor = messageColor
        }else {
            currentDisplayView!.messageLabel.attributedText = messageAttributeText
        }
        
        
        currentDisplayView!.contentView = contentView
    
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimation()
    }
  
    private func startAnimation() {
        
        switch preferredStyle {
            case .Alert:
            
                currentDisplayView?.transform = CGAffineTransformMakeScale(0, 0)
                
                
                UIView.animateWithDuration(AnimationDuration * 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: {
                    
                    self.currentDisplayView?.transform = CGAffineTransformIdentity
                    
                    }, completion: nil)
            break
            default:
                
                currentDisplayView?.transform = CGAffineTransformMakeTranslation(0, view.frame.height)
                
                UIView.animateWithDuration(AnimationDuration * 2, animations: {
                    
                    
                    self.currentDisplayView?.transform = CGAffineTransformIdentity
                    
                    }, completion: nil)
            break
            
        }
        
      
        
    }
    
    private var alertActions = [AlertAction]()
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if preferredStyle != .ActionSheet {
            return
        }
        
        dismiss()
    }
    
    func dismiss() {
        if preferredStyle == .ActionSheet {
            UIView.animateWithDuration(AnimationDuration * 2, animations: {
                self.currentDisplayView?.transform = CGAffineTransformMakeTranslation(0, self.view.frame.height)
                
                }, completion: { (_) in
                    
            })
            
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
   override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        
        transitioningDelegate = self
        modalPresentationStyle = .Custom //只要设置这句，背景就是透明
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private var preferredStyle = AlertControllerStyle.Alert
    
    private var currentDisplayView: BaseView?
    
//    private let dimBackgroundButton: UIButton = UIButton()

    
    private let presentAnimator = TransitionAnimator(transitionAnimate: .present)
    private let dismissAnimator = TransitionAnimator(transitionAnimate: .dismiss)
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return presentAnimator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return dismissAnimator
    }
    

    
        
}
