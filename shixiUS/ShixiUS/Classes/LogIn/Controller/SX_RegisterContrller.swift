//
//  SX_RegisterContrller.swift
//  ShixiUS
//
//  Created by heather on 2018/9/13.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  注册

import UIKit
import SwiftyJSON

class SX_RegisterContrller: UIViewController {
    
    var userNameTF     : SX_TextField?
    var passWordTF     : SX_TextField?
    var email         : SX_TextField?
    
    var backBtn        : UIButton?
    var regBtn         : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ======================================================================================================================
// MARK: - Other Method
// ======================================================================================================================
extension SX_RegisterContrller {
    func setUI() {
        
        title                     = "快速注册"
        self.view.backgroundColor = UIColor.white
        
        self.backBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(50.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
            make.height.width.equalTo(18.FloatValue.IPAD_XValue)
        }).config({ (Back) in
            Back.setImage(UIImage.init(named: "Close"), for: .normal)
            Back.rx.tap.subscribe(onNext: { (_) in
                SXLog("Back")
                self.dismiss(animated: true, completion: {
                    SXLog("退出注册")
                })
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        let logoView = UIImageView(image: #imageLiteral(resourceName: "ShixiLogo")).addhere(toSuperView: self.view).layout { (make) in
            make.top.equalToSuperview().offset(90.FloatValue.IPAD_XValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            make.width.equalTo(150.FloatValue.IPAD_XValue)
            }.config { (Logo) in
        }
        
        self.userNameTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin*2.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin*2.FloatValue.IPAD_XValue)
            make.height.equalTo(40.FloatValue.IPAD_XValue)
        }).config({ (USERNAME) in
            USERNAME.tintColor           = UIColor.SX_MainColor()
            USERNAME.layer.masksToBounds = true
            USERNAME.layer.borderColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            USERNAME.layer.borderWidth   = 0.5
            USERNAME.layer.cornerRadius  = 10
            USERNAME.placeholder         = "请输入用户名"
            USERNAME.textAlignment       = .left
        })
        
        self.passWordTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.userNameTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (PASSWORD) in
            PASSWORD.tintColor           = UIColor.SX_MainColor()
            PASSWORD.layer.masksToBounds = true
            PASSWORD.layer.borderColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            PASSWORD.layer.borderWidth   = 0.5
            PASSWORD.layer.cornerRadius  = 10
            PASSWORD.placeholder         = "请输入密码"
            PASSWORD.textAlignment       = .left
        })
        
        self.email = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.passWordTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (MAIL) in
            MAIL.tintColor               = UIColor.SX_MainColor()
            MAIL.layer.masksToBounds     = true
            MAIL.layer.borderColor       = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            MAIL.layer.borderWidth       = 0.5
            MAIL.layer.cornerRadius      = 10
            MAIL.placeholder             = "请输入邮箱"
            MAIL.textAlignment           = .left
        })
        
        self.regBtn = UIButton().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.email!.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (REG) in
            REG.setTitle("快速注册", for: .normal)
            REG.backgroundColor          = UIColor.SX_MainColor()
            REG.layer.masksToBounds      = true
            REG.layer.cornerRadius       = 10
            
            REG.rx.tap.subscribe(onNext: { (_) in
                SXLog("快速注册")
                
                if self.userNameTF?.text == "" {
                    // 提示 ! ! !
                }

                let str = String(data: (self.passWordTF?.text?.data(using: .utf8)?.base64EncodedData())!, encoding: .utf8)
                
                let param = ["name":self.userNameTF?.text,
                             "email":self.email?.text,
                             "password":str
                            ]

                SX_NetManager.requestData(type: .POST, URlString: SX_Register, parameters: param as? [String : String], finishCallBack: { (result) in
                    do{
                        let json = try JSON(data: result)
                        if json["status"] == 200 {
                            /// 成功
                            SXLog("注册成功! ")
                            self.navigationController?.popViewController(animated: true)
                        } else if json["status"] == 202 {
                            /// 错误状态
                            SXLog("错误状态! ")
                        } else if json["status"] == 203 {
                            /// 超时, 重新登录
                            SXLog("超时, 重新登录! ")
                        }
                    } catch{ }
                })
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
    }
}
