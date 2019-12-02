//
//  ShadowBg.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


class ShadowBgSecond: UICollectionReusableView {
    
    var isOdd: Bool = false{
        didSet{
            if isOdd{
                setNeedsDisplay()
            }
        }
    }
    
    
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
        let rect: UIBezierPath
        if isOdd{
            let upFrame = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: MyLibCtrlLayout.itemHeight, right: 0))
            rect = UIBezierPath(roundedRect: upFrame, byRoundingCorners: [.topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: ShadowFrame.corn, height: ShadowFrame.corn))
            let downFrame = CGRect(origin: CGPoint(x: upFrame.minX, y: upFrame.maxY), size: CGSize(width: MyLibCtrlLayout.doubleItemWidth * 0.5, height: MyLibCtrlLayout.itemHeight))
            rect.append(UIBezierPath(roundedRect: downFrame, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: ShadowFrame.corn, height: ShadowFrame.corn)))
            let midArc = UIBezierPath()
            let midP = CGPoint(x: upFrame.midX, y: upFrame.maxY)
            midArc.move(to: midP)
            midArc.addLine(to: midP.v(ShadowFrame.corn))
            midArc.addArc(withCenter: midP.offset(ShadowFrame.corn, offsetV: ShadowFrame.corn), radius: ShadowFrame.corn, startAngle: CGFloat.pi , endAngle: CGFloat.pi * 1.5, clockwise: true)
            midArc.close()
            rect.append(midArc)
            /*
            UIColor.red.setStroke()
            midArc.stroke()
            // rect.stroke()
            */
        }
        else{
            rect = UIBezierPath(roundedRect: frame, cornerRadius: ShadowFrame.corn)
        }
        let shadow = UIColor.shadowScore
        context.setShadow(offset: CGSize(width: ShadowFrame.rhs, height: ShadowFrame.bottom), blur: 12, color: shadow.cgColor)
        UIColor.white.setFill()
        rect.fill()
    }
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attribute = layoutAttributes as? DecorationLayoutAttributes{
            isOdd = attribute.isOdd
        }
        
    }
}
