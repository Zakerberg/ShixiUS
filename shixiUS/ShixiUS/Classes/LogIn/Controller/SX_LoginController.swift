//
//  SX_LoginController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  登录

import UIKit

class SX_LoginController: UIViewController {
    
    var _loginView: SX_LogInView?
    var _bgView: UIView?
    
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
        self._loginView = SX_LogInView()
        self.view = _loginView
        creatLoginButton()
    }
    
    func creatLoginButton() {
     
        
        
        
        
        
    }
}

// ===============================================================================================================================
// MARK: - UIPickerViewDelegate
// ===============================================================================================================================
extension SX_LoginController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
}

// ===============================================================================================================================
// MARK: - UITextFieldDelegate
// ===============================================================================================================================
extension SX_LoginController: UITextFieldDelegate {
    
    
    
    
    
}

