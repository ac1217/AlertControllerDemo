//
//  ViewController.swift
//  AlertController
//
//  Created by zhangweiwei on 16/6/13.
//  Copyright © 2016年 Erica. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        let ac = AlertController(title: nil, message: "选择照片", contentView: nil, preferredStyle: .ActionSheet)
        
        
        ac.addAction(AlertAction(title: "歪风") { (_) in
            print("sssss")
            })
        
        let action = AlertAction(title: "俯拾地") { (_) in
            print("fdfdsf")
        }
        action.titleColor = UIColor.redColor()
        ac.addAction(action)
        //        ac.addAction(AlertAction(title: "水电费") { (_) in
        //            print("fdfdsf")
        //
        //            })
        //
        //        ac.addAction(AlertAction(title: "水电放费") { (_) in
        //            print("fdfdsf")
        //
        //            })
        //
        //        ac.addAction(AlertAction(title: "第三方费") { (_) in
        //            print("fdfdsf")
        //
        //            })
        
        presentViewController(ac, animated: true, completion: nil)
        
    }
    
    
}

