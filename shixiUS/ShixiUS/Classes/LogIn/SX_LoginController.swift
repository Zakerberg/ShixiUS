//
//  SX_LoginController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  登录

import UIKit

class SX_LoginController: UIViewController {
    
    var numTF: UITextField?
    var passCodeTF: UITextField?
    var logInBtn: UIButton?
    var registerBtn: UIButton?
    var messageCodeBtn: UIButton?
    var forgetBtn: UIButton?
    var backBtn: UIButton?
    
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
// MARK: - SX_ProjectDetailTableViewDelegate
// ===============================================================================================================================
extension SX_LoginController {
    
    func setUI() {
        
        self.view.backgroundColor = UIColor.white
        
        self.backBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make
        }).config({ (backBtn) in
            
        })
        
        let bgView = UIImageView(image: UIImage.init(named: "")).addhere(toSuperView: self.view).layout { (make) in
            
            }.config { (bgView) in
        }
        
        self.numTF = UITextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (numTF) in
            numTF.keyboardType = .numberPad
            numTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        })
        
        self.passCodeTF = UITextField().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (passCodeTF) in
            passCodeTF.keyboardType = .numberPad
            
        })
        
        self.messageCodeBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (messageCodeBtn) in
            
        })
        
        self.forgetBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (forgetBtn) in
            
        })
        
        self.logInBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (logInBtn) in
            logInBtn.isEnabled = false
            logInBtn.backgroundImage(for: .disabled)
            logInBtn.setImage(UIImage.init(named: ""), for: .disabled)
            
        })
        
        self.registerBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (registerBtn) in
        })
    }
}

// ===============================================================================================================================
// MARK: - 
// ===============================================================================================================================
extension SX_LoginController {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        SXLog(textField.text?.lengthOfBytes(using: .utf8))
        
    }
}
