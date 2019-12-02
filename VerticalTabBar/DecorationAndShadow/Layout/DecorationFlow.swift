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
    static let rhs: CGFloat = 20
    static let headerH: CGFloat = 54
    static let itemHeight: CGFloat = 72
}




class DecorationFlow<T: UICollectionReusableView>: UICollectionViewFlowLayout {
    
    
    override func prepare() {
        super.prepare()
        sectionInset = UIEdgeInsets(top: 0, left: MusicLayout.x, bottom: 16, right: MusicLayout.trailing)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        register(T.self, forDecorationViewOfKind: T.id)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.section == 0, let collection = collectionView, elementKind == T.id else{
            return nil
        }
        let attributes = DecorationLayoutAttributes(forDecorationViewOfKind: T.id, with: indexPath)
        let totalWid = UI.width - VerticalTabBarInfo.tabBarWidth
        let width = totalWid - FrontPageFrame.lhs - FrontPageFrame.rhs + ShadowFrame.rhs
        let floor = ceil(Double(collection.numberOfItems(inSection: 0))/2.0)
        let height = CGFloat(floor) * FrontPageFrame.itemHeight + ShadowFrame.bottom
        attributes.frame = CGRect(x: FrontPageFrame.lhs, y: FrontPageFrame.headerH, width: width, height: height)
        attributes.zIndex -= 1
        return attributes
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = super.layoutAttributesForElements(in: rect)
        guard let collection = collectionView, collection.numberOfSections > 0 else{
            return array
        }
        let decorations = layoutAttributesForDecorationView(ofKind: T.id, at: IndexPath(item: 0, section: 0))
        if let decorate = decorations, rect.intersects(decorate.frame){
            array?.append(decorate)
        }
        return array
        
    }
}



