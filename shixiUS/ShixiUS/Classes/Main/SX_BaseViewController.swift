////
////  SX_BaseViewController.swift
////  ShixiUS
////
////  Created by Michael 柏 on 7/19/18.
////  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
////
//
//import UIKit
//
//class SX_BaseViewController: UIViewController {
//
//    lazy var navBar = SX_CustomNavigationBar.CustomNavigationBar()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationController?.navigationBar.isHidden = true
//        automaticallyAdjustsScrollViewInsets = false
//        setupNavBar()
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
//
//extension SX_BaseViewController {
//
//    fileprivate func setupNavBar() {
//        view.addSubview(navBar)
//
//        // 设置自定义导航栏背景图片
//        navBar.barBackgroundImage = UIImage(named: "millcolorGrad")
//
//        // 设置自定义导航栏背景颜色
//        // navBar.backgroundColor = MainNavBarColor
//
//        // 设置自定义导航栏标题颜色
//        navBar.titleLabelColor = .white
//
//        // 设置自定义导航栏左右按钮字体颜色
//        navBar.sx_setTintColor(color: .white)
//
//        if self.navigationController?.childViewControllers.count != 1 {
//            navBar.sx_setLeftButton(title: "<", titleColor: UIColor.white)
//        }
//    }
//
//    @objc fileprivate func back() {
//        _ = navigationController?.popViewController(animated: true)
//    }
//}
//
//
//
//
//
