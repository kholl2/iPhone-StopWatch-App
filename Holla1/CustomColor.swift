//
//  CustomColor.swift
//  Holla1
//
//  Created by Kruthika Holla on 9/15/15.
//  Copyright (c) 2015 Kruthika Holla. All rights reserved.
//

import UIKit

class CustomColor: UIView {

    
    override func drawRect(rect: CGRect) {
        var topRect: CGRect = CGRectMake(0, 0, rect.size.width, rect.size.height/2.0)
        // Fill the rectangle with grey
       UIColor.lightGrayColor().setFill()
       UIRectFill(topRect)
        
        var bottomRect:CGRect = CGRectMake(0, rect.size.height/2.0, rect.size.width, rect.size.height/2.0)
        UIColor.redColor().setFill()
        UIRectFill(bottomRect)
    }

}
