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

class SX_LoginController: UIViewController {
    
    var numTF          : UITextField?
    var backBtn        : UIButton?
    var passCodeTF     : UITextField?
    //    var messageCodeBtn : UIButton?
    //    var countryCodeBtn : UIButton?
    
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

// ======================================================================================================================
// MARK: - Other Method
// ======================================================================================================================
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
        
        let logoView = UIImageView(image: #imageLiteral(resourceName: "ShixiLogo")).addhere(toSuperView: self.view).layout { (make) in
            make.top.equalTo(self.backBtn!.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.centerX.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            make.width.equalTo(150.FloatValue.IPAD_XValue)
            }.config { (Logo) in
        }
        
        self.numTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(logoView.snp.bottom).offset(50.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin*2.FloatValue.IPAD_XValue)
            make.right.equalToSuperview().offset(-Margin*2.FloatValue.IPAD_XValue)
            make.height.equalTo(40.FloatValue.IPAD_XValue)
            
        }).config({ (Num) in
            Num.tintColor = UIColor.SX_MainColor()
            Num.layer.masksToBounds = true
            Num.layer.borderColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            Num.layer.borderWidth   = 0.5
            Num.layer.cornerRadius  = 10
            Num.placeholder         = "请输入用户名"
            Num.textAlignment       = .left
        })
        
        self.passCodeTF = SX_TextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.numTF!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.numTF!)
        }).config({ (PassCode) in
            PassCode.tintColor = UIColor.SX_MainColor()
            PassCode.layer.masksToBounds = true
            PassCode.layer.borderColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 1).cgColor
            PassCode.layer.borderWidth   = 0.5
            PassCode.layer.cornerRadius  = 10
            PassCode.placeholder = "请输入密码"
            PassCode.textAlignment = .left
        })
        
        self.forgetBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.passCodeTF!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
            make.right.equalTo(self.passCodeTF!)
        }).config({ (Forget) in
            Forget.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            Forget.setTitle("忘记密码?", for: .normal)
            Forget.titleLabel?.font = UIFont.systemFont(ofSize: 13.FloatValue)
            Forget.sizeToFit()
            Forget.rx.tap.subscribe(onNext: { (_) in
                SXLog("忘记密码怎么办?")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        self.logInBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.forgetBtn!.snp.bottom).offset(40.FloatValue.IPAD_XValue)
            make.height.left.width.equalTo(self.numTF!)
        }).config({ (LogIn) in
            LogIn.backgroundColor = UIColor.SX_MainColor()
            LogIn.setTitle("登录", for: .normal)
            LogIn.layer.masksToBounds = true
            LogIn.layer.cornerRadius = 10
            
            LogIn.rx.tap.subscribe(onNext: { (_) in
                SXLog("LOGIN")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        self.registerBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.logInBtn!.snp.bottom).offset(Margin)
            make.height.left.width.equalTo(self.logInBtn!)
        }).config({ (Register) in
            Register.backgroundColor = UIColor.white
            Register.setTitle("注册", for: .normal)
            Register.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            Register.layer.masksToBounds = true
            Register.layer.cornerRadius  = 10
            Register.layer.borderWidth   = 0.5
            Register.layer.borderColor   = UIColor.SX_MainColor().cgColor
            
            Register.rx.tap.subscribe(onNext: { (_) in
                SXLog("LOGIN")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
    }
}


// =====================================================================================================================
// MARK: - UIPickerViewDelegate
// =====================================================================================================================
extension SX_LoginController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

// =====================================================================================================================
// MARK: - UITextFieldDelegate
// =====================================================================================================================
extension SX_LoginController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        if textField == self.passCodeTF {
            if (textField.text?.lengthOfBytes(using: .utf8))! > 6 {
                //                textField.text =
            }
            
            let cs = NSCharacterSet(charactersIn: "0123456789").inverted
            // 按cs分离出数组, 数组按""分离出字符串
            let filtered = textField.text?.components(separatedBy: cs).joined(separator: "")
            if textField.text == filtered {
                
            } else {
                SXLog("仅限数字----")
            }
        }
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

