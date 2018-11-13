//
//  SX_MineFixPasswordController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  修改密码

/*
 你身上的味道真好闻
 你身上的味道真好闻
 你身上的味道真好闻
 重要的事情要说三遍
 你总是问我我喜欢你什么
 其实有时候没什么道理,我只是觉得你很好看也很好闻
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_MineFixPasswordController: UIViewController {
    
    var fixBtn: UIButton?
    var password: UITextField?
    var newPassword: UITextField?
    var repeatPassword: UITextField?
    
    lazy var table: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor  = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled  = false
        tableView.delegate         = self
        tableView.dataSource       = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==============================================================================
// MARK: - Other Method
// ==============================================================================
extension SX_MineFixPasswordController {
    
    func setUI() {
        title = "修改密码"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.table)
    }
}

// ==============================================================================
// MARK: - UITableViewDelegate
// ==============================================================================
extension SX_MineFixPasswordController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "原密码"
            self.password = UITextField().addhere(toSuperView: cell.contentView).layout { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                }.config { (TF) in
                    TF.tintColor         = UIColor.SX_MainColor()
                    TF.textAlignment     = .left
                    TF.placeholder       = "输入旧密码"
                    TF.isSecureTextEntry = true
                    TF.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                        if ((self?.password?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.newPassword?.text?.lengthOfBytes(using: .utf8)) != 0 && self?.repeatPassword?.text?.lengthOfBytes(using: .utf8) != 0) {
                            self?.fixBtn?.isEnabled       = true
                            self?.fixBtn?.backgroundColor = UIColor.SX_MainColor()
                        }else{
                            self?.fixBtn?.isEnabled       = false
                            self?.fixBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                        }
                    })
            }
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text    = "新密码"
            self.newPassword = UITextField().addhere(toSuperView: cell.contentView).layout { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                }.config { (TF) in
                    TF.tintColor         = UIColor.SX_MainColor()
                    TF.textAlignment     = .left
                    TF.placeholder       = "新密码"
                    TF.isSecureTextEntry = true
                    TF.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                        if ((self?.password?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.newPassword?.text?.lengthOfBytes(using: .utf8)) != 0 && self?.repeatPassword?.text?.lengthOfBytes(using: .utf8) != 0) {
                            self?.fixBtn?.isEnabled       = true
                            self?.fixBtn?.backgroundColor = UIColor.SX_MainColor()
                        }else{
                            self?.fixBtn?.isEnabled       = false
                            self?.fixBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                        }
                    })
            }
        }else{
            cell.textLabel?.text         = "确认密码"
            self.repeatPassword      = UITextField().addhere(toSuperView: cell.contentView).layout { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                }.config { (TF) in
                    TF.tintColor         = UIColor.SX_MainColor()
                    TF.textAlignment     = .left
                    TF.placeholder       = "再次输入新密码"
                    TF.isSecureTextEntry = true
                    TF.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                        if ((self?.password?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.newPassword?.text?.lengthOfBytes(using: .utf8)) != 0 && self?.repeatPassword?.text?.lengthOfBytes(using: .utf8) != 0) {
                            self?.fixBtn?.isEnabled       = true
                            self?.fixBtn?.backgroundColor = UIColor.SX_MainColor()
                        }else{
                            self?.fixBtn?.isEnabled       = false
                            self?.fixBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                        }
                    })
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let view = UIView()
            self.fixBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(45.FloatValue.IPAD_XValue)
            }).config({ (FIX) in
                FIX.backgroundColor     = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                FIX.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
                FIX.setTitle("修改", for: .normal)
                FIX.layer.masksToBounds = true
                FIX.layer.cornerRadius  = 10
                FIX.isEnabled           = false
                FIX.rx.tap.subscribe(onNext: { (_) in
                    
                    if self.newPassword?.text != self.repeatPassword?.text {
                        let hud         = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode        = .text
                        hud.isSquare    = true
                        hud.label.text  = "两次输入的密码不一致"
                        hud.hide(animated: true, afterDelay: 1.0)
                    }else{
                        
                        let passwordStr = self.password?.text?.base64
                        let str1 = passwordStr?.replacingOccurrences(of: "\n", with: "")
                        let str2 = str1?.replacingOccurrences(of: "\t", with: "")
                        
                        let newPasswordStr = self.newPassword?.text?.base64
                        let str3 = newPasswordStr?.replacingOccurrences(of: "\n", with: "")
                        let str4 = str3?.replacingOccurrences(of: "\t", with: "")
                        
                        let repeatPasswordStr = self.repeatPassword?.text?.base64
                        let str5 = repeatPasswordStr?.replacingOccurrences(of: "\n", with: "")
                        let str6 = str5?.replacingOccurrences(of: "\t", with: "")
                        
                        let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                                     "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!),
                                     "password":str2,
                                     "newpassword":str4,
                                     "repeatpassword":str6
                            ] as! [String : String]
                        
                        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_FixPassword, parameters: param) { (result) in
                            do{
                                let json = try JSON(data: result)
                                if json["status"] == 200 {
                                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    hud.mode       = .text
                                    hud.isSquare   = true
                                    hud.label.text = json["msg"].stringValue
                                    hud.hide(animated: true, afterDelay: 1.0)
                                    self.navigationController?.popViewController(animated: true)
                                }else{
                                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    hud.mode       = .text
                                    hud.isSquare   = true
                                    hud.label.text = json["msg"].stringValue
                                    hud.hide(animated: true, afterDelay: 1.0)
                                }
                            }catch { }
                        }
                    }
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if  section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 100.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return CGFloat.leastNormalMagnitude
        }
        return Margin
    }
}
