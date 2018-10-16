//
//  SX_GuideViewController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 如果有一天你觉得越相爱越是场意外
 那就请你悄悄在月光下
 找个男孩把我取代
 */

import UIKit

class SX_GuideViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// =========================================================
// MARK: - Other Method
// =========================================================
extension SX_GuideViewController {
    
    func setUI() {
        // gif和jpg类型的资源数组
        let imageGifArray = ["guideImage1.jpg","guideImage6.gif", "guideImage8.gif", "guideImage2.jpg","guideImage7.gif", "guideImage5.jpg"]
        let guideView     = SX_GuidePageView.init(images: imageGifArray, loginRegistCompletion: {
            SXLog("登录/注册")
        }) {
            SXLog("开始使用App")
        }
        self.view.addSubview(guideView)
    }
}
