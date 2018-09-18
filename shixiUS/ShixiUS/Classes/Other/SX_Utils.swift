//
//  SX_Utils.swift
//  ShixiUS
//
//  Created by heather on 2018/9/18.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  获取信息的类

import UIKit

class SX_Utils: NSObject {
    
    class func getSign_token() -> NSString{
        return (USERDEFAULTS.object(forKey: "token") as! NSString)
    }
    
    class func getSign_userID() -> NSString{
        
        return (USERDEFAULTS.object(forKey: "userId") as! NSString)
    }
}

