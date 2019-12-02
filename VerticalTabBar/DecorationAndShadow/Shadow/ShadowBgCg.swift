//
//  ShadowBgCg.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/12/2.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit





class ShadowBgCg: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("没实现")
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return  }
        
        let frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: ShadowFrame.bottom, right: ShadowFrame.rhs))
        let rect = UIBezierPath(roundedRect: frame, cornerRadius: ShadowFrame.corn)
        let shadow = UIColor.shadowCompare
        context.setShadow(offset: CGSize(width: ShadowFrame.rhs, height: ShadowFrame.bottom), blur: 12, color: shadow.cgColor)
        UIColor.white.setFill()
        rect.fill()
    }
    
}
