//
//  RecentScoreBg.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

struct ShadowFrame {
    static let corn: CGFloat = 4
    static let rhs: CGFloat = 3
    static let bottom: CGFloat = 5
}


class RecentScoreBg: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        // 不给背景色，默认黑色
        
        // 除非，在 drawRect ,先刷一层底色
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("没实现")
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return  }
        
        let frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: ShadowFrame.bottom, right: ShadowFrame.rhs))
        let rect = UIBezierPath(roundedRect: frame, cornerRadius: ShadowFrame.corn)
        let shadow = UIColor.shadowScore
        context.setShadow(offset: CGSize(width: ShadowFrame.rhs, height: ShadowFrame.bottom), blur: 12, color: shadow.cgColor)
        UIColor.white.setFill()
        rect.fill()
    }
}
