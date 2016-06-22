//
//  SheetView.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

class SheetView: BaseView {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !alertActionButtons.isEmpty {
            
            let btnH: CGFloat = 44
      
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
        
        
//        center = superview!.center
        center.x = superview!.center.x
        frame.origin.y = superview!.frame.height - frame.height - 10

    }

}
