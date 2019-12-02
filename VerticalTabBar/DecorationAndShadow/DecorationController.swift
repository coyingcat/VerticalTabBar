//
//  DecorationController.swift
//  musicSheet
//
//  Created by Jz D on 2019/8/19.
//  Copyright © 2019 上海莫小臣有限公司. All rights reserved.
//

import UIKit



struct MyLibCtrlLayout {
    static let x: CGFloat = 20
    static let trailing: CGFloat = 20
    static let headerH: CGFloat = 54
    static let sectionHeaderH: CGFloat = 72
}



class DecorationController: TabController {
    
    lazy var contentCollcection: UICollectionView = {
        let layout = DecorationFlow()
        layout.sectionInset = UIEdgeInsets(top: 0, left: MyLibCtrlLayout.x, bottom: 16, right: MyLibCtrlLayout.trailing)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(rgb: 0xF9F8F8)
        collection.delegate = self
        collection.dataSource = self

        
        collection.register(cell: PracticeRecentlyItem.self)
        collection.registerH(zoo: ScoreReusableHeader.self)
     
  
        return collection
    }()

    
    var trailing_hide: NSLayoutConstraint!
    
    var secondInfo:(layout: UICollectionViewFlowLayout, tip: String) = (UICollectionViewFlowLayout(), "阴影效果"){
        didSet{
            contentCollcection.setCollectionViewLayout(secondInfo.layout, animated: false)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = secondInfo.tip
        navigationController?.navigationBar.prefersLargeTitles = true
        
        contentCollcection.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentCollcection)
        let top_contentCollcection = contentCollcection.topAnchor.constraint(equalTo: view.topAnchor)
        let leading_contentCollcection = contentCollcection.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing_contentCollcection = contentCollcection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom_contentCollcection = contentCollcection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading_contentCollcection, trailing_contentCollcection, top_contentCollcection, bottom_contentCollcection])
        

    }

}




extension DecorationController: UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UI.width - VerticalTabBarInfo.tabBarWidth - FrontPageFrame.lhs - FrontPageFrame.rhs
        let size = CGSize(width: width * 0.5, height: MyLibCtrlLayout.sectionHeaderH)
       
        return size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UI.width - VerticalTabBarInfo.tabBarWidth
        return CGSize(width: width, height: MyLibCtrlLayout.headerH)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        return CGSize.zero
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
     
        return CGFloat.zero
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat.zero
        
    }
   
}






extension DecorationController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = 5
            // debug
         //   count = 3
            
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: PracticeRecentlyItem.self, ip: indexPath)
        let record = Info.data[indexPath.item]
        cell.config(record.scores_name, description: record.desp)
        cell.layer.debug()
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == ScoreReusableHeader.header else {
            return UICollectionReusableView.placeHolder
        }
        let header = collectionView.dequeueH(zoo: ScoreReusableHeader.self, ip: indexPath)
        let source: (title: String, willShow: Bool, symbol: String) = ("最近练习", true, "score_practice_recent")
        header.config(symbol: source.symbol, title: source.title, showMore: source.willShow)
        return header
    }
    
}
 



