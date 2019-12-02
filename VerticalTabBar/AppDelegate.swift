//
//  AppDelegate.swift
//  VerticalTabBar
//
//  Created by Jz D on 2019/8/24.
//  Copyright © 2019 Jz D. All rights reserved.
//

import UIKit




@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let controllers = { () -> [UIViewController] in
            let controller = UIViewController()
            let title = "点不了"
            controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named:"magnifying-glass"), tag: 0)
            controller.view.backgroundColor = UIColor.blue
            let shadows: [UIViewController] = Array(0...2).map{
                let decorate = DecorationController()
                let title: String
                switch $0{
                case 0:
                    title = "阴影效果"
                case 1:
                    title = "阴影效果 cg"
                    decorate.secondInfo = (DecorationFlow<ShadowBgCg>(), title)
                case 2:
                    title = "阴影效果二"
                    decorate.secondInfo = (DecorationFlowSecond<ShadowBgSecond>(), title)
                default:
                    title = "tbd"
                }
                let ctrl = UINavigationController(rootViewController: decorate)
                ctrl.tabBarItem = UITabBarItem(title: title, image: UIImage(named:"magnifying-glass"), tag: $0 + 1)
                return ctrl
            }
            let imgCtrl = UINavigationController(rootViewController: DecorationImgController())
            imgCtrl.tabBarItem = UITabBarItem(title: "图片", image: UIImage(named:"magnifying-glass"), tag: 9)
            return shadows + [imgCtrl, controller]
        }()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(controllers)
        window?.makeKeyAndVisible()
        
        return true
    }
 

}

