//
//  DecorationFlow.swift
//  musicSheet
//
//  Created by Jz D on 2019/11/29.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit


struct FrontPageFrame {
    static let lhs: CGFloat = 20
    static let rhs: CGFloat = 24
    static let headerH: CGFloat = 54
    static let sectionHeaderH: CGFloat = 72
}




class DecorationFlow: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        register(RecentScoreBg.self, forDecorationViewOfKind: RecentScoreBg.id)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    // 同时不影响我们正常的 UICollectionViewDelegateFlowLayout 代理，设置布局信息
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.section == 0, let collection = collectionView, elementKind == RecentScoreBg.id else{
            return nil
        }
        let attributes = DecorationLayoutAttributes(forDecorationViewOfKind: RecentScoreBg.id, with: indexPath)
        let totalWid = UI.width - VerticalTabBarInfo.tabBarWidth
        let width = totalWid - FrontPageFrame.lhs - FrontPageFrame.rhs + ShadowFrame.cornerTrailing
        let floor = ceil(Double(collection.numberOfItems(inSection: 0))/2.0)
        let height = CGFloat(floor) * FrontPageFrame.sectionHeaderH + ShadowFrame.shadowOffset
        attributes.frame = CGRect(x: FrontPageFrame.lhs, y: FrontPageFrame.headerH, width: width, height: height)
        attributes.zIndex -= 1
        return attributes
        
    }
    // 涂色大法好，解决涂色部分
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = super.layoutAttributesForElements(in: rect)
        guard let collection = collectionView, collection.numberOfSections > 0 else{
            return array
        }
        let decorations = layoutAttributesForDecorationView(ofKind: RecentScoreBg.id, at: IndexPath(item: 0, section: 0))
        if let decorate = decorations, rect.intersects(decorate.frame){
            array?.append(decorate)
        }
        return array
        
    }
}




// 信封，用于传递，转交

// 信使，用于送达，就像是快递
