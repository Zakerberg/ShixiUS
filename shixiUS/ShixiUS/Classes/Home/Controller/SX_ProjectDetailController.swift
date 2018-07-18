//
//  SX_ProjectDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/18/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目详情

import UIKit

class SX_ProjectDetailController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// =================================================================================================================================
// MARK: - Other Method
// =================================================================================================================================
extension SX_ProjectDetailController {
    
    func setUI() {
        self.navigationController?.navigationBar.barTintColor = UIColor.SX_MainColor()
        self.navigationController?.navigationBar.subviews[0].alpha = 0
    }
    
    func fetchData() {
       
        
        
        
        
    }
}

// =================================================================================================================================
// MARK: - UIScrollViewDelegate
// =================================================================================================================================
extension SX_ProjectDetailController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
       
        //获取ScrollView的偏移量y
        let offsetY = scrollView.contentOffset.y
        print(offsetY)
        //自己设置需要滚动到哪里可以完全显示导航栏
        let ScrollValue:CGFloat = 64.0
        //将偏移量除以需要滚动的量,可以得到需要显示的透明度
        var alpha = offsetY / ScrollValue
        if alpha >= 1{
            alpha = 1
        }
        //将透明度赋值给第一个View即可
        self.navigationController?.navigationBar.subviews[0].alpha = alpha
    }
}
