//
//  SX_BaseAlertController.swift
//  ShixiUS
//
//  Created by heather on 2018/9/28.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 《破阵子》
 
 人生不过三天
 去今往来何年
 不为红颜眉一笑
 此生何必作仙凡
 一朝醉万年
 
 逍遥天外飞仙
 蓬莱此去东南
 灵鹤送我真情录
 薄毡不解月夜寒
 为伊又难眠
 */

import UIKit

class SX_BaseAlertController: UIAlertController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configAlert()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//=============================================================================
// MARK: - configAlert
//=============================================================================
extension SX_BaseAlertController {
    
    func configAlert() {
        
        /// 标题字体的样式(红色, 放大)
        let titleFont = UIFont.systemFont(ofSize: 20)
        let titleAttribute = NSMutableAttributedString.init(string: self.title!)
        titleAttribute.addAttributes([(kCTFontAttributeName as! NSAttributedStringKey):titleFont,
                                      kCTForegroundColorAttributeName as! NSAttributedStringKey:UIColor.red],
                                     range:NSMakeRange(0, (self.title?.characters.count)!))
        
        self.setValue(titleAttribute, forKey: "attributedTitle")
        
        /// 消息内容样式
        let messageFontDescriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptor.AttributeName.family: "Arial",
            UIFontDescriptor.AttributeName.name: "Arial-ItalicMT"])
        
        let messageFont = UIFont(descriptor: messageFontDescriptor, size: 13.0)
        let messaeAttribute = NSMutableAttributedString(string: self.message!)
        messaeAttribute.addAttributes([(kCTFontAttributeName as! NSAttributedStringKey):messageFont, kCTForegroundColorAttributeName as! NSAttributedStringKey: UIColor.gray], range :NSMakeRange(0, (self.message?.characters.count)!))
        self.setValue(messaeAttribute, forKey: "attributedMessage")
    }
}
