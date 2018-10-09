//
//  SX_LoginController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  登录

/*
 愿你所有的温柔
 都能换来
 岁月的情深意浓
 可以不必回首
 相扶白头
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_LoginController: UIViewController {
    
    var userNameTF     : SX_TextField?
    var backBtn        : UIButton?
    var passWordTF     : SX_TextField?
    
    var logInBtn       : UIButton?
    var forgetBtn      : UIButton?
    var registerBtn    : UIButton?
    
    typealias SuccessClosure = (String, String) ->()
    var closure: SuccessClosure!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "LOGINSUCCEED"), object: nil)
    }
}

// =============================================================================
// MARK: - Other Method
// =============================================================================
extension SX_LoginController {
    
    func setUI() {
        
        self.view.backgroundColor = UIColor.white
        
        self.backBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(50.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
            make.height.width.equalTo(18.FloatValue.IPAD_XValue)
        }).config({ (Back) in
            Back.setImage(UIImage.init(named: "Close"), for: .normal)
            Back.rx.tap.subscribe(onNext: { (_) in
                SXLog("Back")
                ///  点击 back 发送通知 退回到之前的 tabbbar
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "TOPRESENTTABBAR"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: {
                    SXLog("dissmiss")
                })
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        let logoView = UIImageView(image: #imageLiteral(resourceName: "ShixiLogo")).addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(self.backBtn!.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            make.width.equalTo(150.FloatValue.IPAD_XValue)
            }.config { (LOGO) in
        }
        
        self.userNameTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin*2.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin*2.FloatValue.IPAD_XValue)
            make.height.equalTo(40.FloatValue.IPAD_XValue)
            
        }).config({ (NUM) in
            NUM.tintColor = UIColor.SX_MainColor()
            NUM.layer.masksToBounds      = true
            NUM.layer.borderColor        = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            NUM.layer.borderWidth        = 0.5
            NUM.layer.cornerRadius       = 10
            NUM.placeholder              = "请输入用户名"
            NUM.textAlignment            = .left
            NUM.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                SXLog("开始编辑账号....")
                if ((self?.userNameTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.passWordTF?.text?.lengthOfBytes(using: .utf8)) != 0) {
                    self?.logInBtn?.isEnabled = true
                    self?.logInBtn?.backgroundColor = UIColor.SX_MainColor()
                }else{
                    self?.logInBtn?.isEnabled = false
                    self?.logInBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                }
            })
            
            // 按下return
            NUM.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
                [weak self] (_) in
                self?.passWordTF?.becomeFirstResponder()
            })
        })
        
        self.passWordTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.userNameTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (PASSWORD) in
            PASSWORD.tintColor = UIColor.SX_MainColor()
            PASSWORD.layer.masksToBounds           = true
            PASSWORD.layer.borderColor             = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            PASSWORD.layer.borderWidth             = 0.5
            PASSWORD.layer.cornerRadius            = 10
            PASSWORD.placeholder                   = "请输入密码"
            PASSWORD.returnKeyType                 = .done
            PASSWORD.textAlignment                 = .left
            PASSWORD.enablesReturnKeyAutomatically = true
            PASSWORD.clearButtonMode               = .whileEditing
            PASSWORD.isSecureTextEntry             = true
            
            PASSWORD.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                SXLog("开始编辑密码....")
                
                if ((self?.userNameTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.passWordTF?.text?.lengthOfBytes(using: .utf8)) != 0) {
                    self?.logInBtn?.isEnabled       = true
                    self?.logInBtn?.backgroundColor = UIColor.SX_MainColor()
                }else{
                    self?.logInBtn?.isEnabled       = false
                    self?.logInBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                }
            })
            
            // 按下return
            PASSWORD.rx.controlEvent(.editingDidEndOnExit).subscribe(onNext: {
                [weak self] (_) in
                
            })
        })
        
        self.forgetBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.passWordTF!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalTo(self.passWordTF!)
        }).config({ (FORGET) in
            FORGET.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            FORGET.setTitle("忘记密码?", for: .normal)
            FORGET.titleLabel?.font = UIFont.systemFont(ofSize: 13.FloatValue)
            FORGET.sizeToFit()
            FORGET.rx.tap.subscribe(onNext: { (_) in
                SXLog("忘记密码怎么办?")
                let fixVC = SX_MineFixPasswordController()
                self.navigationController?.show(fixVC, sender: nil)
                
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        self.logInBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.forgetBtn!.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.height.left.width.equalTo(self.userNameTF!)
        }).config({ (LOGIN) in
            LOGIN.backgroundColor     = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
            LOGIN.setTitle("登录", for: .normal)
            LOGIN.setTitleColor(UIColor.white, for: .normal)
            LOGIN.layer.masksToBounds = true
            LOGIN.layer.cornerRadius  = 10
            LOGIN.isEnabled           = false
            
            LOGIN.rx.tap.subscribe(onNext: { (_) in
                SXLog("LOGIN")
                /// 请求
                let str   = self.passWordTF?.text?.base64
                let str1  = str?.replacingOccurrences(of: "\n", with: "")
                let str2  = str1?.replacingOccurrences(of: "\t", with: "")
                let param = ["name":self.userNameTF?.text,
                             "password":str2]
                
                SX_NetManager.requestData(type: .POST, URlString: SX_LogIn, parameters: param as? [String : String], finishCallBack: { (result) in
                    do{
                        let json = try JSON(data: result)
                        if json["status"].int == 200 {
                            SXLog("登录成功! ----> \(json["msg"])")
                            let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode       = .text
                            hud.isSquare   = true
                            hud.label.text = "登陆成功"
                            hud.hide(animated: true, afterDelay: 1.0)
                            USERDEFAULTS.set(json["data"]["token"].rawString(), forKey: "token")
                            USERDEFAULTS.set(json["data"]["userId"].rawString(), forKey: "userId")
                            USERDEFAULTS.set("yes", forKey: "login")
                            
                            let statusStr  = "1"
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LOGINSUCCESS"), object: nil, userInfo: ["name":json["data"]["userName"].rawString()!])
                            guard(self.closure != nil) else{
                                self.dismiss(animated: true, completion: nil)
                                return
                            }
                            self.closure(json["data"]["userName"].rawString()!,statusStr)
                            self.dismiss(animated: true, completion: nil)
                        }else{
                            let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode       = .text
                            hud.isSquare   = true
                            hud.label.text = json["msg"].stringValue
                            hud.hide(animated: true, afterDelay: 1.0)
                            self.dismiss(animated: true, completion: nil)
                        }
                    } catch{ }
                })
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        self.registerBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.logInBtn!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.logInBtn!)
        }).config({ (REGISTER) in
            REGISTER.setTitle("快速注册", for: .normal)
            REGISTER.backgroundColor     = UIColor.white
            REGISTER.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            REGISTER.layer.masksToBounds = true
            REGISTER.layer.cornerRadius  = 10
            REGISTER.layer.borderWidth   = 0.5
            REGISTER.layer.borderColor   = UIColor.SX_MainColor().cgColor
            
            REGISTER.rx.tap.subscribe(onNext: { (_) in
                SXLog("注册 ++++ ")
                let vc = SX_RegisterContrller()
                self.present(vc, animated: true, completion: nil)
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
    }
}

// =========================================================================================
// MARK: - Other Method 2
// =========================================================================================
extension SX_LoginController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.passWordTF?.resignFirstResponder()
        self.userNameTF?.resignFirstResponder()
        self.backBtn?.resignFirstResponder()
    }
    
    func callBack(closure :@escaping SuccessClosure) {
        self.closure = closure
    }
}

class SX_TextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}
