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
            var controls = [UIViewController]()
            for i in 0..<4{
                let controller = UIViewController()
                let title = "tab \(i+1)"
                controller.tabBarItem = UITabBarItem(title: title, image: UIImage(named:"magnifying-glass"), tag: i)
                controls.append(controller)
            }
            controls[0].view.backgroundColor = UIColor.blue
            controls[1].view.backgroundColor = UIColor.red
            controls[2].view.backgroundColor = UIColor.green
            controls[3].view.backgroundColor = UIColor.purple
            let shadows: [UIViewController] = Array(0...2).map{
                let ctrl = UINavigationController(rootViewController: DecorationController())
                ctrl.view.backgroundColor = UIColor.white
                let title = "shadow \($0 + 1)"
                ctrl.tabBarItem = UITabBarItem(title: title, image: UIImage(named:"magnifying-glass"), tag: $0 + 4)
                return ctrl
            }
            return shadows + controls
        }()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(controllers)
        window?.makeKeyAndVisible()
        
        return true
    }
 

}

