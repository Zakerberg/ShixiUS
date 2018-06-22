//
//  SX_TabBarController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_TabBarController: UITabBarController {

    static let SX_HomeVC               : NSString = "SX_HomeVC"
    static let SX_MineVC               : NSString = "SX_MineVC"
    static let SX_VIPCenterVC          : NSString = "SX_VIPCenterVC"
    static let SX_TabbarTitle          : NSString = "SX_TabbarTitle"
    static let SX_TabbarImage          : NSString = "SX_TabbarImage"
    static let SX_TabbarSelectedImage  : NSString = "SX_TabbarSelectedImage"
    static let SX_TabbarItemBadgeValue : NSString = "SX_TabbarItemBadgeValue"
    
    var vcsOrder : NSArray {
        get{
            return [SX_TabBarController.SX_HomeVC,SX_TabBarController.SX_VIPCenterVC,SX_TabBarController.SX_MineVC]
        }
    }
    
    var vcsInfoDict : NSDictionary {
        get{
            return [
                SX_TabBarController.SX_HomeVC : [
                    SX_TabBarController.SX_TabbarTitle          : "首页",
                    SX_TabBarController.SX_TabbarImage          : "Home",
                    SX_TabBarController.SX_TabbarSelectedImage  : "Home_Selected",
                    SX_TabBarController.SX_TabbarItemBadgeValue : 0
                ],
                
                SX_TabBarController.SX_VIPCenterVC : [
                    SX_TabBarController.SX_TabbarTitle          : "我的申请",
                    SX_TabBarController.SX_TabbarImage          : "Application",
                    SX_TabBarController.SX_TabbarSelectedImage  : "Application_Selected",
                    SX_TabBarController.SX_TabbarItemBadgeValue : 0
                ],
                
                SX_TabBarController.SX_MineVC : [
                    SX_TabBarController.SX_TabbarTitle          : "我的",
                    SX_TabBarController.SX_TabbarImage          : "Mine",
                    SX_TabBarController.SX_TabbarSelectedImage  : "Mine_Selected",
                    SX_TabBarController.SX_TabbarItemBadgeValue : 0
                ]
            ]
        }
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = CGFloat(kTabBarHeight)
        tabFrame.origin.y = self.view.frame.size.height - CGFloat(kTabBarHeight)
        self.tabBar.frame = tabFrame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubVCs()
    }
    
    func setupSubVCs() {
        self.vcsOrder.enumerateObjects { (vcName, index, stop) in
            
            let vcInfo: NSDictionary = self.vcsInfoDict.object(forKey: vcName) as! NSDictionary
            guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                SXLog("获取命名空间失败!")
                return
            }
            let vcClass: AnyClass? = NSClassFromString(spaceName + ".\(vcName)")
            guard let typeClass = vcClass as? UIViewController.Type else{
                SXLog("vcClass不能当做UIViewController!")
                return
            }
            let vc = typeClass.init()
            vc.title = vcInfo[SX_TabBarController.SX_TabbarTitle] as! NSString as String
            vc.tabBarItem.image = UIImage.init(named: vcInfo[SX_TabBarController.SX_TabbarImage] as! NSString as String)
            let SelectedImage = UIImage.init(named: vcInfo[SX_TabBarController.SX_TabbarSelectedImage] as! NSString as String)
            vc.tabBarItem.selectedImage = SelectedImage
            vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey(rawValue: kCIAttributeName) : UIColor.SX_MainColor()], for: .selected)
            
            let nav = SX_NavigationController(rootViewController: vc)
            self.addChildViewController(nav)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



