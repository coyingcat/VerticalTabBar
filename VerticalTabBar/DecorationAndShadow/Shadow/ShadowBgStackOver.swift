//
//  ShadowBg.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


class ShadowBgStackOver: UICollectionReusableView {
    
    var isOdd: Bool = false{
        didSet{
            if isOdd{
                setNeedsDisplay()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       //  backgroundColor = UIColor.red
        // backgroundColor = UIColor.clear
        backgroundColor = UIColor.white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("没实现")
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return  }
     
        let frame = bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: ShadowFrame.bottom, right: ShadowFrame.rhs))
        var pathes = [UIBezierPath]()
        
        
        if isOdd{
            let upFrame = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: MusicLayout.itemHeight, right: 0))
            let rectUp = UIBezierPath(roundedRect: upFrame, byRoundingCorners: [.topLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: ShadowFrame.corn, height: ShadowFrame.corn))
            let downFrame = CGRect(origin: CGPoint(x: upFrame.minX, y: upFrame.maxY), size: CGSize(width: MusicLayout.doubleItemWidth * 0.5, height: MusicLayout.itemHeight))
            let rectDown = UIBezierPath(roundedRect: downFrame, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: ShadowFrame.corn, height: ShadowFrame.corn))
            let midArc = UIBezierPath()
            let midP = CGPoint(x: upFrame.midX, y: upFrame.maxY)
            midArc.move(to: midP)
            midArc.addLine(to: midP.v(ShadowFrame.corn))
            midArc.addArc(withCenter: midP.offset(ShadowFrame.corn, offsetV: ShadowFrame.corn), radius: ShadowFrame.corn, startAngle: CGFloat.pi , endAngle: CGFloat.pi * 1.5, clockwise: true)
            midArc.close()
            pathes.append(contentsOf: [rectUp, rectDown, midArc])
        }
        else{
            let rect = UIBezierPath(roundedRect: frame, cornerRadius: ShadowFrame.corn)
            pathes.append(rect)
        }
        let shadow = UIColor.shadowScore
        context.setShadow(offset: CGSize(width: ShadowFrame.rhs, height: ShadowFrame.bottom), blur: 12, color: shadow.cgColor)
        context.beginTransparencyLayer(auxiliaryInfo: nil)
        UIColor.white.setFill()
        pathes.forEach { $0.fill() }
        context.endTransparencyLayer()
    }
    

    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attribute = layoutAttributes as? DecorationLayoutAttributes{
            isOdd = attribute.isOdd
        }
        
    }
}
