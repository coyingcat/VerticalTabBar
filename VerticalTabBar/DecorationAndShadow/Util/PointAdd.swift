//
//  PointAdd.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/12/2.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


extension CGPoint{
    func v(_ offset: CGFloat) -> CGPoint{
        CGPoint(x: x, y: y + offset)
    }
    
    
    
    func h(_ offset: CGFloat) -> CGPoint{
        CGPoint(x: x + offset, y: y)
    }
    
    
    func offset(_ offsetH: CGFloat, offsetV: CGFloat) -> CGPoint{
        CGPoint(x: x + offsetH, y: y + offsetV)
    }
    
}
