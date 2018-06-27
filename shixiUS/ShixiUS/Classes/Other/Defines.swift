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




