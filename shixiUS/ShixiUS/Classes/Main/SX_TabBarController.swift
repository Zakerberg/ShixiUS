//
//  SX_TabBarController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 如果你执意去远方寻找宝藏
 就让我化身战车
 跟在你身旁
 我来承受道路曲折
 你只管完成你的梦想
 */

import UIKit

class SX_TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAllViewController()
        self.tabBar.tintColor = UIColor.SX_MainColor()
    }
}

extension SX_TabBarController {
    
    // 添加所有控件
    func setUpAllViewController() -> Void {
        setUpChildController(SX_HomeVC(), "首页","Home","Home_Selected")
        setUpChildController(SX_MyApplyController(), "我的申请",  "Application",  "Application_Selected")
        setUpChildController(SX_MineVC(), "我的",  "Mine",  "Mine_Selected")
    }
    
    // 设置子控件属性
    private func setUpChildController(_ controller : UIViewController,_ title : String,_ norImage : String,_ selectedImage : String){
        
        controller.tabBarItem.title = title
        // 修改TabBar标题位置
        controller.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3)
        controller.tabBarItem.image                   = UIImage(named: norImage)
        controller.tabBarItem.selectedImage           = UIImage(named: selectedImage)
        // 设置 NavigationController
        let nav = SX_NavigationController(rootViewController: controller)
        controller.title = title
        self.addChildViewController(nav)
    }
}
