//
//  SX_BaseControler.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_BaseControler: UIViewController {
    
    var pageLoadingView: UIView!
    var loadingView:UIView!
    var loadingImageView: UIImageView!
    var loadingLabel: UILabel!
    var _failureHintView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//extension SX_BaseControler {
//    // 加载失败
//    func showPageLoadingFailedWithReload(_ target: Any, action: Selector) {
//
//        if !(loadingView != nil) {
//            loadingView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kNavH - kTabBarHeight))
//            pageLoadingView.backgroundColor = UIColor.init(red: 0.86, green: 0.89, blue: 0.91, alpha: 1)
//        }
//        self.view.addSubview(pageLoadingView)
//
//    }
//}

