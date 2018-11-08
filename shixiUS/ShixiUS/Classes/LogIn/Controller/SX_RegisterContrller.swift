//
//  SX_RegisterContrller.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/13.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  注册

/*
 时光
 刚刚好
 等我来爱你
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_RegisterContrller: UIViewController {
    
    var userNameTF: SX_TextField?
    var passWordTF: SX_TextField?
    var email: SX_TextField?
    
    var backBtn: UIButton?
    var regBtn: UIButton?
    //    var eyeBtn: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// =========================================================================================
// MARK: - Other Method
// =========================================================================================
extension SX_RegisterContrller {
    func setUI() {
        
        title = "快速注册"
        self.view.backgroundColor = UIColor.white
        self.backBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(50.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
            make.height.width.equalTo(18.FloatValue.IPAD_XValue)
        }).config({ (Back) in
            Back.setImage(#imageLiteral(resourceName: "Close"), for: .normal)
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
        
        self.userNameTF = SX_TextField(frame: CGRect.zero, isSecure: false).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
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
            
            USERNAME.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                SXLog("开始编辑密码....")
                if ((self?.userNameTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.passWordTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.email?.text?.lengthOfBytes(using: .utf8)) != 0) {
                    self?.regBtn?.isEnabled = true
                    self?.regBtn?.backgroundColor = UIColor.SX_MainColor()
                }else{
                    self?.regBtn?.isEnabled = false
                    self?.regBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                }
            })
            
            // 按下return
            USERNAME.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
                [weak self] (_) in
                self?.passWordTF?.becomeFirstResponder()
            })
        })
        
        self.passWordTF = SX_TextField(frame: CGRect.zero, isSecure: true).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
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
            PASSWORD.isSecureTextEntry   = true
            
            PASSWORD.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                SXLog("开始编辑密码....")
                if ((self?.userNameTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.passWordTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.email?.text?.lengthOfBytes(using: .utf8)) != 0) {
                    self?.regBtn?.isEnabled = true
                    self?.regBtn?.backgroundColor = UIColor.SX_MainColor()
                }else{
                    self?.regBtn?.isEnabled = false
                    self?.regBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                }
            })
            
            // 按下return
            PASSWORD.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
                [weak self] (_) in
                self?.email?.becomeFirstResponder()
            })
        })
        
        self.email = SX_TextField(frame: CGRect.zero, isSecure: false).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.passWordTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (EMAIL) in
            EMAIL.tintColor               = UIColor.SX_MainColor()
            EMAIL.layer.masksToBounds     = true
            EMAIL.layer.borderColor       = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            EMAIL.layer.borderWidth       = 0.5
            EMAIL.layer.cornerRadius      = 10
            EMAIL.placeholder             = "请输入邮箱"
            EMAIL.textAlignment           = .left
            
            EMAIL.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                SXLog("开始编辑密码....")
                
                if ((self?.userNameTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.passWordTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.email?.text?.lengthOfBytes(using: .utf8)) != 0) {
                    self?.regBtn?.isEnabled = true
                    self?.regBtn?.backgroundColor = UIColor.SX_MainColor()
                }else{
                    self?.regBtn?.isEnabled = false
                    self?.regBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                }
            })
            
            // 按下return
            EMAIL.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
                [weak self] (_) in
            })
        })
        
        self.regBtn = UIButton().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.email!.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (REG) in
            REG.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
            REG.setTitle("快速注册", for: .normal)
            REG.setTitleColor(UIColor.white, for: .normal)
            REG.layer.masksToBounds = true
            REG.layer.cornerRadius  = 10
            REG.isEnabled           = false
            
            REG.addTarget(self, action: #selector(regClick), for: .touchUpInside)
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passWordTF?.resignFirstResponder()
        self.email?.resignFirstResponder()
        self.userNameTF?.resignFirstResponder()
        self.backBtn?.resignFirstResponder()
    }
    
    
    @objc func regClick() {
        SXLog("快速注册")
        let str = self.passWordTF?.text?.base64
        let str1 = str?.replacingOccurrences(of: "\n", with: "")
        let str2 = str1?.replacingOccurrences(of: "\t", with: "")
        let param = ["name":self.userNameTF?.text,
                     "email":self.email?.text,
                     "password":str2]
        
        if self.passWordTF?.text == "" {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.isSquare = true
            hud.label.text = "请输入密码"
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }else if self.userNameTF?.text == "" {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.isSquare = true
            hud.label.text = "请输入用户名"
            hud.hide(animated: true, afterDelay: 1.0)
            return
        } else if self.email?.text == "" {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.isSquare = true
            hud.label.text = "请输入注册邮箱"
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }else if (self.email?.text?.isValiteEmail())! == false {
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.isSquare = true
            hud.label.text = "输入邮箱格式不正确"
            hud.hide(animated: true, afterDelay: 1.0)
            return
        }
        
        SX_NetManager.requestData(type: .POST, URlString: SX_Register, parameters: param as? [String : String], finishCallBack: { (result) in
            do{
                let json = try JSON(data: result)
                if json["status"] == 200 {
                    SXLog("注册成功!")
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = .text
                    hud.isSquare = true
                    hud.label.text = "注册成功"
                    hud.hide(animated: true, afterDelay: 1.0)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode = .text
                    hud.isSquare = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                }
            } catch{ }
        })
    }
}

