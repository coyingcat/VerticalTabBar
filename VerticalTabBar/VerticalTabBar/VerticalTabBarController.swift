//
//  VerticalTabBarController.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/8/25.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit



@objc protocol TabBarControllerDelegate: class {
    @objc optional
    func tabBarController(_ tabBarController: VerticalTabBarController, didSelect viewController: UIViewController)
    @objc optional
    func tabBarController(_ tabBarController: VerticalTabBarController, shouldSelect viewController: UIViewController) -> Bool
}



class VerticalTabBarController: UIViewController {
    
    var delegate: TabBarControllerDelegate?
    let tabBar = VerticalTabTable(frame: CGRect(x: 0, y: 0, width: 100, height: UIScreen.main.bounds.height))
    
    var tabBarWidth: CGFloat = 100
    
    
    var selectedViewController: UIViewController{
        get{
            return viewControllers[selectedIndex]
        }
        set(newValue){
            selectedIndex = viewControllers.firstIndex(of: newValue) ?? 0
        }
    }
    
    
    var _selectedIndex: Int = -1
    var selectedIndex: Int{
        get{
            return _selectedIndex
        }
        set(newValue){
            if newValue != selectedIndex, newValue < viewControllers.count{
                let selectedViewController = viewControllers[newValue]
                addChild(selectedViewController)
                selectedViewController.view.frame = CGRect(x: tabBarWidth, y: 0, width: view.bounds.size.width - tabBarWidth, height: view.bounds.size.height)
                view.addSubview(selectedViewController.view)
                if selectedIndex >= 0{
                    let previousViewController = viewControllers[selectedIndex]
                    previousViewController.view.removeFromSuperview()
                    previousViewController.removeFromParent()
                }
                _selectedIndex = newValue
                guard let items = tabBar.items else{
                    return
                }
                if selectedIndex < items.count{
                    tabBar.selectedItem = items[selectedIndex]
                }
                delegate?.tabBarController?(self, didSelect: selectedViewController)
            }
        }
    }
    
    let viewControllers: [UIViewController]
    
    
    init(_ controllers: [UIViewController]) {
        
        viewControllers = controllers
        tabBar.items = viewControllers.map { (controller: UIViewController) -> UITabBarItem in
            return controller.tabBarItem
        }
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        viewControllers = []
        super.init(coder: aDecoder)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tabBar.delegate = self
        view.addSubview(tabBar)
    }
    
}




extension VerticalTabBarController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let new = viewControllers[indexPath.row]
        let result = delegate?.tabBarController?(self, shouldSelect: new)
        if let answer = result, answer{
            return indexPath
        }
        else{
            return tableView.indexPathForSelectedRow
        }
    }
}
