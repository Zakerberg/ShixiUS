//
//  SX_NavigationController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SX_NavigationController.setNavBarTheme()
        SX_NavigationController.setupBarButtonItemTheme()
    }
    
    // MARK: - setNavBarTheme
    class func setNavBarTheme() {
        let apprance : UINavigationBar = UINavigationBar.appearance()
        apprance.tintColor = UIColor.white
        apprance.setBackgroundImage(UIImage.imageWithColor(color: UIColor.SX_MainColor(), size: CGSize.init(width: 1.0, height: 1.0)), for: .any, barMetrics: .default)
        apprance.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white,
                                        NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)]
        apprance.shadowImage = UIImage.imageWithColor(color: UIColor.SX_MainColor(), size: CGSize.init(width: 0.6, height: 0.6))
    }
    
    // MARK: - setupBarButtonItemTheme
    class func setupBarButtonItemTheme() {
        let apprance: UIBarButtonItem = UIBarButtonItem.appearance()
        apprance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.SX_MainColor(), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)], for: .normal)
        apprance.setTitleTextAttributes([NSAttributedStringKey.foregroundColor : UIColor.SX_MainColor(), NSAttributedStringKey.font : UIFont.systemFont(ofSize: 16)], for: .selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
