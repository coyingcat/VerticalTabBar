//
//  ShadowBg.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


class ImageBg: UICollectionReusableView {
    
    var bg: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        bg.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bg)
        NSLayoutConstraint.activate([
            bg.leadingAnchor.constraint(equalTo: leadingAnchor),
            bg.trailingAnchor.constraint(equalTo: trailingAnchor),
            bg.topAnchor.constraint(equalTo: topAnchor),
            bg.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("没实现")
    }
    
    
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        if let attribute = layoutAttributes as? DecorationLayoutAttributes{
            if let name = attribute.imgName{
                bg.image = UIImage(named: name)
            }
        }
        
    }
    
}
