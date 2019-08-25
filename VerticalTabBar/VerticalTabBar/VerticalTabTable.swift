//
//  VerticalTabTable.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/8/25.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class VerticalTabTable: UITableView {

    var items: [UITabBarItem]?{
        didSet{
            reloadData()
        }
    }
    
    
    var selectionIndicatorImage = {()->UIImage? in
        var img = UIImage(named: "selectionIndicatorImage")
        img = img?.resizableImage(withCapInsets: UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6))
        return img
    }(){
        didSet{
            reloadData()
        }
    }
    
    
    var selectedImageTintColor: UIColor?{
        didSet{
            reloadData()
        }
    }
    
    
    var _backgroundGradientColors: [CGColor?]?
    var backgroundGradientColors: [CGColor?]?{
        get{
            return _backgroundGradientColors
        }
        set(newVal){
            guard newVal != backgroundGradientColors else {
                return
            }
            _backgroundGradientColors = newVal
            if backgroundView == nil{
                backgroundView = UIView()
                backgroundView?.backgroundColor = UIColor.clear
            }
            guard let background = backgroundView , let gradientColors = backgroundGradientColors, let backgroundSublayers = backgroundView?.layer.sublayers else {
                return
            }
            for layer in backgroundSublayers{
                layer.removeFromSuperlayer()
            }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = bounds
            gradientLayer.colors = gradientColors as [Any]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            background.layer.addSublayer(gradientLayer)
            
        }
    }
    
    
    
    var backgroundImage: UIImage?{
        didSet{
        if let background = backgroundImage, background.capInsets == UIEdgeInsets.zero{
                // aka non resizable image
                backgroundView = UIView()
                backgroundColor = UIColor.clear
                backgroundView?.backgroundColor = UIColor(patternImage: background)
            }
            else{
                backgroundView = UIImageView(image: backgroundImage)
            }
        }
        
    }
    
    
    
    var selectedItem: UITabBarItem?{
        get{
            if let tabBars = items, let ip = indexPathForSelectedRow{
                return tabBars[ip.row]
            }
            else{
                return nil
            }
        }
        set(newValue){
            guard let tabBars = items, let item = newValue else{
                return
            }
            let selectedItemIndex = tabBars.firstIndex(of: item)
            if let selectedIndex = selectedItemIndex{
                selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition.top)
            }
        }
    }
    
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: UITableView.Style.plain)
        register(TabBarCell.self, forCellReuseIdentifier: TabBarCell.id)
        dataSource = self
        rowHeight = 80
        separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        if let tabBars = items{
            isScrollEnabled = rowHeight*CGFloat(tabBars.count) > bounds.height
        }
        
    }


}




extension VerticalTabTable: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TabBarCell.id, for: indexPath) as! TabBarCell
        cell.selectedBackgroundView = UIImageView(image: selectionIndicatorImage)
        let tabBarItem = items?[indexPath.row]
        if let tabItem = tabBarItem{
            cell.textLabel?.text = tabItem.title
            cell.icon = tabItem.image
        }
        return cell
        
    }
}
