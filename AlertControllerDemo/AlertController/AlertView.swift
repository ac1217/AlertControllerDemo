//
//  AlertView.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

class AlertView: BaseView {
    
//    override func setupUI() {
//        
//        super.setupUI()
//        
//        layer.backgroundColor = UIColor.whiteColor().CGColor
//        
//        
//    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
                
        if !alertActionButtons.isEmpty {
            
            let btnH: CGFloat = 44
            
            if alertActionButtons.count < 3 {
                
                let btnW = frame.width / CGFloat(alertActionButtons.count)
                let btnY = frame.height
                
                for i in 0..<alertActionButtons.count {
                    
                    let btn = alertActionButtons[i]
                    
                    let btnX = CGFloat(i) * btnW
                    
                    btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH)
                    
                    let s = seperators[i]
                    if i == 0 {
                       s.frame = CGRect(x: 0, y: btnY, width: frame.width, height: 1)
                    }else {
                        
                        s.frame = CGRect(x: btnX, y: btnY, width: 1, height: btnH)
                    }
                  
                }
                
                frame.size.height = btnY + btnH
                
            }else {
                
                let btnW = frame.width
                
                for i in 0..<alertActionButtons.count {
                    
                    let btn = alertActionButtons[i]
                    
                    let btnY = frame.height + CGFloat(i) * btnH
                    
                    btn.frame = CGRect(x: 0, y: btnY, width: btnW, height: btnH)
                    
                    let s = seperators[i]
                    s.frame = CGRect(x: 0, y: btnY, width: frame.width, height: 1)
                    
                }
                
                frame.size.height = alertActionButtons.last!.frame.maxY
                
            }
        }
        
        center = superview!.center
    }
    
  
    
}
