//
//  SX_TabBarController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVc = SX_HomeVC()
        let firstNavController = SX_NavigationController(rootViewController: homeVc)
        firstNavController.navigationBar.barTintColor = UIColor.SX_MainColor()
        firstNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Home"), selectedImage: UIImage(named: "Home_Selected"))
        firstNavController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, -10, 0)

        let vipCenterVC = SX_VIPCenterVC()
        let secondNavController = SX_NavigationController(rootViewController: vipCenterVC)
        secondNavController.navigationBar.tintColor = UIColor.SX_MainColor()
        secondNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Application"), selectedImage: UIImage(named: "Application_Selected"))
        secondNavController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0 , -10, 0)

        let mineVC = SX_MineVC()
        let thirdNavController = SX_NavigationController(rootViewController: mineVC)
        thirdNavController.navigationBar.tintColor = UIColor.SX_MainColor()
        thirdNavController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "Mine"), selectedImage: UIImage(named: "Mine_Selected"))
        thirdNavController.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0 , -10, 0)

        setTbaBarApperence()
        self.setViewControllers([firstNavController,secondNavController,thirdNavController], animated: true)
    
       setTbaBarApperence()
    }
}

extension SX_TabBarController {
    
    func setTbaBarApperence() {
        let tabBarApperence = UITabBar.appearance()
        tabBarApperence.shadowImage = UIImage()
        tabBarApperence.tintColor = UIColor.SX_MainColor()
    }
}




