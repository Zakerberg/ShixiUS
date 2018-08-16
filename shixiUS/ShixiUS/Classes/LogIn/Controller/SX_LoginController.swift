//
//  SX_LoginController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  登录

import UIKit

class SX_LoginController: UIViewController {
    
    var numTF          : UITextField?
    var backBtn        : UIButton?
    var passCodeTF     : UITextField?
    var messageCodeBtn : UIButton?
    var countryCodeBtn : UIButton?
    
    var logInBtn       : UIButton?
    var forgetBtn      : UIButton?
    var registerBtn    : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
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
                self.dismiss(animated: true, completion: {
                    SXLog("dissmiss")
                })
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        let logoView = UIImageView(image: UIImage.init(named: "ShixiLogo")).addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(self.backBtn!.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            make.width.equalTo(150.FloatValue.IPAD_XValue)
            }.config { (Logo) in
        }
        
        self.countryCodeBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin*2.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin*2.FloatValue.IPAD_XValue)
            make.height.equalTo(40.FloatValue.IPAD_XValue)
        }).config({ (CountryCode) in
            CountryCode.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            CountryCode.setTitle("+86", for: .normal)
            CountryCode.contentHorizontalAlignment = .left
            CountryCode.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            CountryCode.layer.masksToBounds = true
            CountryCode.layer.borderColor  = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            CountryCode.layer.borderWidth  = 0.5
            CountryCode.layer.cornerRadius = 10
            
            CountryCode.rx.tap.subscribe(onNext: { (_) in
                SXLog("countryCode")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        let line = UIImageView().addhere(toSuperView: self.countryCodeBtn!).layout { (make) in
            make.top.equalToSuperview().offset(10.FloatValue.IPAD_XValue)
            make.bottom.equalToSuperview().offset(-10.FloatValue.IPAD_XValue)
            make.width.equalTo(0.5)
            make.left.equalToSuperview().offset(60.FloatValue.IPAD_XValue)
            }.config { (Line) in
                
                Line.image = UIImage.imageWithColor(color: UIColor.colorWithHexString(hex: "cccccc", alpha: 1), size: CGSize(width: 1, height: 30.FloatValue.IPAD_XValue))
        }
        
        self.numTF = UITextField().addhere(toSuperView: self.countryCodeBtn!).layout(snapKitMaker: { (make) in
            make.top.bottom.right.equalToSuperview()
            make.left.equalTo(line.snp.right).offset(Margin)
        }).config({ (Num) in
            Num.keyboardType = .numberPad
            Num.layer.masksToBounds = true
            Num.layer.borderColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            Num.layer.cornerRadius = 10
            Num.placeholder = "请输入您的手机号码"
            Num.textAlignment = .left
        })
        
        
        self.passCodeTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.numTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.countryCodeBtn!)
        }).config({ (PassCode) in
            PassCode.keyboardType = .numberPad
            PassCode.layer.masksToBounds = true
            PassCode.layer.borderColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            PassCode.layer.borderWidth   = 0.5
            PassCode.layer.cornerRadius  = 10
            PassCode.placeholder = "短信验证码"
            PassCode.textAlignment = .left
        })
        
        
        
        
        
        
        
        //        self.messageCodeBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
        //
        //        }).config({ (messageCodeBtn) in
        //
        //        })
        //
        //        self.forgetBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
        //
        //        }).config({ (forgetBtn) in
        //
        //        })
        //
        //        self.logInBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
        //
        //        }).config({ (logInBtn) in
        //            logInBtn.isEnabled = false
        //            logInBtn.backgroundImage(for: .disabled)
        //            logInBtn.setImage(UIImage.init(named: ""), for: .disabled)
        //        })
        //
        //        self.registerBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
        //
        //        }).config({ (registerBtn) in
        //        })
        
        
        
        
    }
    
    //    func creatLoginButton() {
    //        self._loginView?.isUserInteractionEnabled = true
    //
    //        /// 登录
    //        self._loginView?.logInBtn?.rx.tap.subscribe(onNext: { (_) in
    //            SXLog("登录")
    //        }, onError: { (error) in
    //            SXLog(error)
    //        }, onCompleted: nil, onDisposed: nil)
    //
    //        /// 注册
    //        self._loginView?.registerBtn?.rx.tap.subscribe(onNext: { (_) in
    //            SXLog("注册注册")
    //        }, onError: { (error) in
    //            SXLog(error)
    //        }, onCompleted: nil, onDisposed: nil)
    //
    //        /// 短信验证码
    //        self._loginView?.messageCodeBtn?.rx.tap.subscribe(onNext: { (_) in
    //            SXLog("短信验证码")
    //        }, onError: { (error) in
    //            SXLog(error)
    //        }, onCompleted: nil, onDisposed: nil)
    //
    //        /// 返回
    //        self._loginView?.backBtn?.rx.tap.subscribe(onNext: { (_) in
    //             SXLog("返回")
    //            self.navigationController?.dismiss(animated: true, completion: nil)
    //        }, onError: { (error) in
    //            SXLog(error)
    //        }, onCompleted: nil, onDisposed: nil)
    //
    //        /// 忘记密码
    //        self._loginView?.forgetBtn?.rx.tap.subscribe(onNext: { (_) in
    //            SXLog("忘记密码")
    //        }, onError: { (error) in
    //            SXLog(error)
    //        }, onCompleted: nil, onDisposed: nil)
    //
    //       /// 将以上的数据全部存储到Usderdefaults中
    //        let userDefaults: UserDefaults = UserDefaults.standard
    //        self._loginView?.numTF?.text = userDefaults.object(forKey: "phone") as? String
    //
    //   }
}

// ===============================================================================================================================
// MARK: - UIPickerViewDelegate
// ===============================================================================================================================
//extension SX_LoginController: UIPickerViewDelegate, UIPickerViewDataSource {
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 10
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return 10
//    }
//}

// ===============================================================================================================================
// MARK: - UITextFieldDelegate
// ===============================================================================================================================
//extension SX_LoginController: UITextFieldDelegate {
//
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//
//        if textField == self._loginView?.passCodeTF {
//            if (textField.text?.lengthOfBytes(using: .utf8))! > 6 {
////                textField.text =
//            }
//
//            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
//            // 按cs分离出数组, 数组按""分离出字符串
//            let filtered = textField.text?.components(separatedBy: cs).joined(separator: "")
//            if textField.text == filtered {
//
//            } else {
//                self._loginView?.passCodeTF?.text = ""
//                SXLog("仅限数字----")
//            }
//        }
//    }
//}


class SX_TextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.insetBy(dx: 10, dy: 0)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 0)
    }
}

