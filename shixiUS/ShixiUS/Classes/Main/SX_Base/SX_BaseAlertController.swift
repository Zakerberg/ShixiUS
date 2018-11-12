//
//  SX_BaseAlertController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/28.
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

enum AlertBtnClickIndex {
    case cancle
    case sure
}

class SX_BaseAlertController: UIView {
    
    typealias SureClosure = ((NSInteger) ->())
    var closure: SureClosure!
    var contentView:UIView?
    var title:UILabel?
    var message:UILabel?
    var surebtn:UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        
    }
}

//===================================================
// MARK: -
//===================================================
extension SX_BaseAlertController {
    
    func config() {
        
        self.frame = UIScreen.main.bounds
        self.backgroundColor = UIColor(white: 0.5, alpha: 0.85)
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
        
        self.contentView = UIView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.center.equalToSuperview()
            make.height.equalTo(150.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40.FloatValue.IPAD_XValue)
        }).config({ (CONTENTVIEW) in
            CONTENTVIEW.backgroundColor    = UIColor.white
            CONTENTVIEW.layer.cornerRadius = 6
        })
        
        self.title = UILabel().addhere(toSuperView: self.contentView!).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make
        }).config({ (TITLE) in
            
        })
        
        self.message = UILabel().addhere(toSuperView: self.contentView!).layout(snapKitMaker: { (make) in
            
        }).config({ (TITLE) in
            
        })

    }
}
