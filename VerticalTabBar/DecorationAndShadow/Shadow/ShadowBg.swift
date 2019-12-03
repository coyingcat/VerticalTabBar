//
//  ShadowBg.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


struct ShadowFrame {
    static let corn: CGFloat = 4
    static let rhs: CGFloat = 1
    static let bottom: CGFloat = 2
}


class ShadowBg: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.shadowScore.cgColor
        layer.shadowOffset = CGSize(width: ShadowFrame.rhs, height: ShadowFrame.bottom)
    }
    
    required init?(coder: NSCoder) {
        fatalError("没实现")
    }
}
