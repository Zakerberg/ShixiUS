//
//  SX_ApplySucceedController.swift
//  ShixiUS
//
//  Created by heather on 2018/9/17.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请成功界面

/*
 曾经的诺言
 被岁月的风渐渐吹散
 不知它最后飘落在谁的心间
 */

import UIKit

class SX_ApplySucceedController: UIViewController {
    
    /// 申请序号
    var ApplyNum:String?
    var str = "实习网就业顾问 将在俩个工作日内联系您 (因为时差问题请谅解)"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==============================================================================================
// MARK: - Other Method
// ==============================================================================================
extension SX_ApplySucceedController {
    func setUI() {
        title = "申请成功"
        view.backgroundColor = UIColor.white
    
        let imageV = UIImageView(image: #imageLiteral(resourceName: "icon_ApplySucceed")).addhere(toSuperView: self.view).layout { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Margin+kNavH)
            make.width.height.equalTo(45.FloatValue.IPAD_XValue)
            }.config { (SUCCEED) in
        }
        
        let succeedL = UILabel().addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(imageV.snp.bottom).offset(Margin)
            make.centerX.equalTo(imageV)
            make.height.equalTo(16.FloatValue.IPAD_XValue)
            }.config { (SUCCEEDL) in
                SUCCEEDL.sizeToFit()
                SUCCEEDL.text      = "恭喜您,职位申请成功!"
                SUCCEEDL.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                SUCCEEDL.font      = UIFont.boldSystemFont(ofSize: 15)
        }
        
        let applyNum = UILabel().addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(succeedL.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.height.equalTo(15)
            }.config { (NUMBER) in
                NUMBER.sizeToFit()
                NUMBER.text      = "申请序号: " + self.ApplyNum!
                NUMBER.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                NUMBER.font      = UIFont.systemFont(ofSize: 14)
        }

        let contentL = UILabel().addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(applyNum).offset(Margin)
            make.left.equalTo(applyNum)
//            make.height.equalTo(UILabel.SX_getSpaceLabelHeight(self.str as NSString, font: UIFont.systemFont(ofSize: 12), width: SCREEN_WIDTH-20, space: 0, zpace: 0))
            }.config { (CONTENT) in
                CONTENT.text          = self.str
                CONTENT.numberOfLines = 0
                CONTENT.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                CONTENT.font          = UIFont.systemFont(ofSize: 14)
        }

        _ = UIButton(type: .custom).addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(contentL.snp.bottom).offset(35.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            }.config { (CONFIRM) in
                CONFIRM.backgroundColor     = UIColor.SX_MainColor()
                CONFIRM.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
                CONFIRM.setTitle("确定", for: .normal)
                CONFIRM.layer.masksToBounds = true
                CONFIRM.layer.cornerRadius  = 10
                CONFIRM.rx.tap.subscribe(onNext: { (_) in
                    self.navigationController?.popViewController(animated: true)
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
        }
    }
}
