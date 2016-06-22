//
//  BaseView.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/22.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    var alertActionButtonDidClick: (() -> ())?
    
    var seperators = [CALayer]();
    var alertActionButtons = [UIButton]();
    
    var alertActions: [AlertAction]? {
        didSet {
            
            if alertActions == nil {
                return
            }
            
            for i in 0..<alertActions!.count {
                
                let alertAction = alertActions![i]
                let btn = UIButton()
                btn.tag = i
                btn.setTitleColor(alertAction.titleColor, forState: UIControlState.Normal)
                btn.setTitle(alertAction.title, forState: .Normal)
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, DefaultMargin, 0, 0)
                btn.titleLabel?.font = UIFont.systemFontOfSize(16)
                
                btn.addTarget(self, action: #selector(AlertView.alertActionBtnClick(_:)), forControlEvents: .TouchUpInside)
                if alertAction.image != nil {
                    btn.setImage(alertAction.image, forState: .Normal)
                    
                }
                
                addSubview(btn)
                alertActionButtons.append(btn)
                
                let s = CALayer()
                
                s.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.1).CGColor
                
                layer.addSublayer(s)
                seperators.append(s)
                
            }
            
            
        }
    }
    
    func alertActionBtnClick(btn: UIButton) {
        
        let alertAction = alertActions![btn.tag]
        alertAction.handler?(alertAction)
        
        alertActionButtonDidClick?()
        
    }

    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.userInteractionEnabled = true
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
    lazy var messageLabel: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.userInteractionEnabled = true
        label.textAlignment = NSTextAlignment.Center
        return label
    }()
    
    var contentView: UIView? {
        didSet{
            if contentView != nil {
                addSubview(contentView!)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI(){
        
        layer.cornerRadius = 10
        
        layer.backgroundColor = UIColor.whiteColor().CGColor
        
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let maxSize = CGSize(width: frame.width - 2 * DefaultMargin, height: CGFloat(MAXFLOAT))
        
        let titleSize = titleLabel.sizeThatFits(maxSize)
        titleLabel.frame = CGRect(x: DefaultMargin, y: titleSize.height == 0 ? 0 : DefaultMargin, width: frame.width - 2 * DefaultMargin, height: titleSize.height)
        
        
        let messageSize = messageLabel.sizeThatFits(maxSize)
        messageLabel.frame = CGRect(x: DefaultMargin, y: titleLabel.frame.maxY + (messageSize.height == 0 ? 0 : DefaultMargin), width: titleLabel.frame.width, height: messageSize.height)
        
        if self.isKindOfClass(AlertView)  {
            
            frame.size.width = superview!.frame.width * 0.75
        }else {
            
            frame.size.width = superview!.frame.width * 0.9
        }
        
        if contentView == nil {
            frame.size.height = messageLabel.frame.maxY + DefaultMargin
        }else {
            contentView!.center = CGPoint(x: frame.width * 0.5, y: messageLabel.frame.maxY + DefaultMargin + contentView!.frame.height * 0.5)
            
            frame.size.height = contentView!.frame.maxY + DefaultMargin
            
        }
        
    }

}
