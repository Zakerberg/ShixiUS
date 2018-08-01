//
//  SX_ProjectDetailInstructionsView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/1/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  项目详情界面 项目说明(项目亮点,日程安排....)View

import UIKit

class SX_ProjectDetailInstructionsView: UIView {
    
    typealias titleClickClosure = ((NSInteger)->Void)
    var titleClosure: titleClickClosure?
    
    var titles: Array<Any>?
    var bottomView: UIView?
    var indicateLine:UIView?
    var instructionBtn: UIButton?
    var titleBtnArray :NSMutableArray?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        ConfigCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - ConfigCell()
// ===============================================================================================================================
extension SX_ProjectDetailInstructionsView {
    
    func ConfigCell() {
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40.FloatValue.IPAD_XValue)
        self.backgroundColor = UIColor.green
        let titleArr = ["项目亮点","日程安排","费用说明","预定须知"]
        let btnWidth = SCREEN_WIDTH/4
        
        for i in 0...titleArr.count {
            self.instructionBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview()
                make.left.equalToSuperview().offset(i*Int(btnWidth))
                make.width.equalTo(btnWidth)
                make.height.equalToSuperview()
            }).config { (btn) in
                btn.setTitle(titleArr[i], for: .normal)
                if i == 0 {
                    btn.setTitleColor(UIColor.black, for: .normal)
                }else{
                    btn.setTitleColor(UIColor.SX_MainColor(), for: .normal)
                }
                btn.setTitleColor(UIColor.SX_MainColor(), for: .selected)
                btn.tag = i
                self.titleBtnArray?.add(btn)
                
                btn.rx.tap.subscribe(onNext: { (_) in
                    SXLog("点击了按钮\(btn.title)")
                    let tag = btn.tag
                    
                    self.setItemSelected(colunm: tag)
                    if (self.titleClosure != nil) {
                        self.titleClosure!(tag)
                    }
                    
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            }
        }
        
        self.indicateLine = UIView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.width.equalTo(self.instructionBtn!)
            make.width.equalTo(1.FloatValue.IPAD_XValue)
            make.top.equalTo(self.instructionBtn!.snp.bottom).offset(1)
        }).config({ (indicateLine) in
            indicateLine.backgroundColor = UIColor.SX_MainColor()
        })
    }
    
    func setItemSelected(colunm: NSInteger) {
        for index in 0...self.titleBtnArray!.count {
            let btn = titleBtnArray![index] as! UIButton
            if index == colunm {
                btn.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            }else{
                btn.setTitleColor(UIColor.colorWithHexString(hex: "ff7900", alpha: 1), for: .normal)
            }
        }
        let btnWidth = SCREEN_WIDTH/CGFloat(self.titleBtnArray!.count)
        self.indicateLine?.frame = CGRect(x: btnWidth*CGFloat(colunm), y: 49, width: btnWidth, height: 1)
    }
}
