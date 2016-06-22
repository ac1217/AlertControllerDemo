//
//  AlertAction.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

class AlertAction: NSObject {
    var title: String
    var image: UIImage?
    var titleColor: UIColor = UIColor.darkGrayColor()
    
    var handler: ((AlertAction) -> Void)?
    
    init(title: String, handler: ((AlertAction) -> Void)?) {
        self.title = title
        self.handler = handler
        super.init()
        
    }
}
