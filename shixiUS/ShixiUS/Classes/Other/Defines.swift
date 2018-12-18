//
//  Defines.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我爱你
 听过最动听的情歌
 是你轻哼的摇篮曲
 最可口的美食
 是你做的烧带鱼
 你用毕生温柔
 却只盼我无忧一生 
 */

import UIKit

let SCREEN_BOUNDS = UIScreen.main.bounds
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH  = UIScreen.main.bounds.size.width
let USERDEFAULTS  = UserDefaults.standard

let iphoneX       = UIApplication.shared.statusBarFrame.size.height > 20 ? true : false
let kNavH         = (SCREEN_HEIGHT == 812 ? 88 : 64).FloatValue
let kTabBarHeight = (iphoneX ? 83.FloatValue : 49.FloatValue)

// 间距
let Margin:CGFloat = 15

// 轮播图高度
let IMAGE_HEIGHT:CGFloat = 240
// 导航栏变色的点
let NAVBAR_COLORCHANGE_POINT = IMAGE_HEIGHT - CGFloat(kNavH * 2)

// 下拉距离
let SCROLL_DOWN_LIMIT:CGFloat = 100
let LIMIT_OFFSET_Y:CGFloat    = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)

