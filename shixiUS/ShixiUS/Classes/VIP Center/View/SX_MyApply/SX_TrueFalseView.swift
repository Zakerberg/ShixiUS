//
//  SX_TrueFalseView.swift
//  ShixiUS
//
//  Created by heather on 2018/9/11.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训申请表里面的 是否有签证, 是否在校选择View

import UIKit

class SX_TrueFalseView: UIView {
    
    /// 是否有签证Arr
    var VisaArr :NSMutableArray = {
        let arr1 = [["title":"有"], ["value":"0"],
                        ["title":"否"], ["value":"1"]]
        
        
        return arr1 as! NSMutableArray
    }()
    
    /// 是否毕业Arr
    var graduationArr: NSMutableArray = {
        let arr2 = [["title":"在校"], ["value":"0"],
                    ["title":"毕业"], ["value":"1"]]
        
        return arr2 as! NSMutableArray
    }()
    
    var truefalseStr: NSString?
    var truefalseView: UIView?


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ==================================================================================================================
// MARK: - Other Method
// =================================================================================================================
extension SX_TrueFalseView {
    func setUI() {
     self.backgroundColor = UIColor.colorWithRGB(r: 0, g: 0, b: 0)
     self.alpha = 0.5
        
        
        
        
        
    }
}

// ==================================================================================================================
// MARK: - UIGestureRecognizerDelegate
// =================================================================================================================
extension SX_TrueFalseView: UIGestureRecognizerDelegate {
    
    
    
    
    
    
    
}




