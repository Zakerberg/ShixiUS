//
//  Defines.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let iphoneX = (SCREEN_WIDTH == 375 && SCREEN_HEIGHT == 812 ?  true : false)
let kNavH = (SCREEN_HEIGHT == 812 ? 88 : 64).FloatValue
let kTabBarHeight = (iphoneX ? 83.FloatValue : 49.FloatValue)

// 间距
let Margin:CGFloat = 15


// 轮播图高度
let IMAGE_HEIGHT:CGFloat = 240
// 导航栏变色的点
let NAVBAR_COLORCHANGE_POINT = IMAGE_HEIGHT - CGFloat(kNavH * 2)

extension SX_NavigationBar {
    class func isIphoneX() -> Bool {
        return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
    }
    class func navBarBottom() -> Int {
        return self.isIphoneX() ? 88 : 64;
    }
    class func tabBarHeight() -> Int {
        return self.isIphoneX() ? 83 : 49;
    }
    class func screenWidth() -> Int {
        return Int(UIScreen.main.bounds.size.width)
    }
    class func screenHeight() -> Int {
        return Int(UIScreen.main.bounds.size.height)
    }
}




