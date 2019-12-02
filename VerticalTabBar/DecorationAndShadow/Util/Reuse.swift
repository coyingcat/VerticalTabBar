
//
//  Reuse.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/12/1.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit



extension UICollectionView{
    
    func register<T: CellReuse>(cell forNib: T.Type){
        register(UINib(nibName: forNib.id, bundle: nil), forCellWithReuseIdentifier: forNib.id)
    }
    
    
    func dequeue<T: CellReuse>(cell forNib: T.Type, ip indexPath: IndexPath) -> T{
        
        return dequeueReusableCell(withReuseIdentifier: forNib.id, for: indexPath) as! T
    }
    
    
    
    func registerH<T: CellReuse>(zoo forNib: T.Type){
        register(UINib(nibName: forNib.id, bundle: nil), forSupplementaryViewOfKind: UICollectionReusableView.header, withReuseIdentifier: forNib.id)
           
    }
       
       
    func dequeueH<T: CellReuse>(zoo forNib: T.Type, ip indexPath: IndexPath) -> T{
       
        return dequeueReusableSupplementaryView(ofKind: UICollectionReusableView.header, withReuseIdentifier: forNib.id, for: indexPath) as! T
    }

    func registerF<T: CellReuse>(zoo forNib: T.Type){
        register(UINib(nibName: forNib.id, bundle: nil), forSupplementaryViewOfKind: UICollectionReusableView.footer, withReuseIdentifier: forNib.id)
           
    }
       
       
    func dequeueF<T: CellReuse>(zoo forNib: T.Type, ip indexPath: IndexPath) -> T{
       
        return dequeueReusableSupplementaryView(ofKind: UICollectionReusableView.footer, withReuseIdentifier: forNib.id, for: indexPath) as! T
    }
    
}




protocol CellReuse {
    static var id: String {get}
}



extension UITableViewCell: CellReuse{
    static var id: String{
        return String(describing: self)
        
    }
    
    
    static let placeHolder = UITableViewCell()

}


extension UICollectionReusableView{
    static let header = "UICollectionElementKindSectionHeader"
    
    static let footer = "UICollectionElementKindSectionFooter"
    
    static let placeHolder = UICollectionReusableView()
}


extension UICollectionViewCell{
    
    static let place = UICollectionViewCell()
}



extension UICollectionReusableView: CellReuse{
    static var id :String {
       // print(String(describing: self))
        return String(describing: self)
    }
}
