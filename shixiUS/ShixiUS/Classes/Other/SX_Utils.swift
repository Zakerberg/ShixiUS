//
//  SX_Utils.swift
//  ShixiUS
//
//  Created by heather on 2018/9/18.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  获取信息的类

/*
茫茫人海中
错过了该错过的
放弃了该放弃的
于是，终于等到了你
 */

import UIKit

class SX_Utils: NSObject {
    
    class func getSign_token() -> String {
        return USERDEFAULTS.object(forKey: "token") as! String
    }
    
    class func getSign_userID() -> String {
        return USERDEFAULTS.object(forKey: "userId") as! String
    }
}

