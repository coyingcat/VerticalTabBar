//
//  ViewController.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/8/24.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit

class ViewController: VerticalTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        delegate = self
        let colors: [CGColor] = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        tabBar.backgroundGradientColors = colors
        // selectedViewController = viewControllers[1]
        selectedViewController = viewControllers[0]   
    }
}



extension ViewController: TabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: VerticalTabBarController, shouldSelect viewController: UIViewController) -> Bool{
        let indexNotSelected = viewControllers.count - 1
        if let index = viewControllers.firstIndex(of: viewController), index == indexNotSelected{
            return false
        }
        return true
    }
    
}
