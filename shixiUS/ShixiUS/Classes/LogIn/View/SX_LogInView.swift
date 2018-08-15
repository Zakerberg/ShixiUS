//
//  SX_LogInView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/15/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  

import UIKit

class SX_LogInView: UIView {
   
    var numTF: UITextField?
    var passCodeTF: UITextField?
    var logInBtn: UIButton?
    var registerBtn: UIButton?
    var messageCodeBtn: UIButton?
    var forgetBtn: UIButton?
    var backBtn: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ==================================================================================================================================
//  MARK: - lazy
// ==================================================================================================================================
extension SX_LogInView {
    
    func configView() {
        
        self.backBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make
        }).config({ (backBtn) in
            
        })
        
        let bgView = UIImageView(image: UIImage.init(named: "")).addhere(toSuperView: self).layout { (make) in
            
            }.config { (bgView) in
        }
        
        self.numTF = UITextField().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (numTF) in
            numTF.keyboardType = .numberPad
            numTF.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        })
        
        self.passCodeTF = UITextField().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (passCodeTF) in
            passCodeTF.keyboardType = .numberPad
            
        })
        
        self.messageCodeBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (messageCodeBtn) in
            
        })
        
        self.forgetBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (forgetBtn) in
            
        })
        
        self.logInBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (logInBtn) in
            logInBtn.isEnabled = false
            logInBtn.backgroundImage(for: .disabled)
            logInBtn.setImage(UIImage.init(named: ""), for: .disabled)
        })
        
        self.registerBtn = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (registerBtn) in
        })
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        SXLog(textField.text?.lengthOfBytes(using: .utf8))
    }
}

