//
//  BaseController.swift
//  musicSheet
//
//  Created by Jz D on 2019/8/28.
//  Copyright © 2019 上海莫小臣有限公司. All rights reserved.
//

import UIKit

class TabController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let controllers = navigationController?.children, controllers.count == 1{
            showBottomBar()
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let controllers = navigationController?.children, controllers.count == 2{
            hideBottomBar()
        }
    }
    
    
    func hideBottomBar(){
        let controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        if let tab = controller as? VerticalTabBarController{
            tab.adjustLayout(false)
        }
    }
    
    
    func showBottomBar(){
        let controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        if let tab = controller as? VerticalTabBarController{
            tab.adjustLayout()
        }
    }
}


