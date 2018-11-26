//
//  SX_MinePersonalController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息

/*
 想打张白条给你
 上面就写着:
 我欠你一声温柔 半世呵护
 分期一万年
 */

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift
import MBProgressHUD

class SX_MinePersonalController: UIViewController {
    
    var titleArr   = ["头像", "用户名", "手机号", "国家/地区", "微信", "邮箱"]
    // var contentArr = ["", , ]
    var getUrlDataArr: Array<Any>?
    
    var iconImageView: UIImageView?
    var nameTF: UITextField?
    var phoneTF: UITextField?
    var countryTF: UITextField?
    var mailTF: UITextField?
    var weChatTF: UITextField?
    var saveBtn: UIButton?
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name:NSNotification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHidden), name:NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = false
        setUI()
        fetchInfoData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==============================================================================
// MARK: - Other method
// ==============================================================================
extension SX_MinePersonalController {
    
    func setUI() {
        title = "个人信息"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.table)
    }
    
    func fetchData() {
        let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                     "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!),
                     "headpic":"",
                     "username":self.nameTF!.text ?? "",
                     "country":self.countryTF!.text ?? "",
                     "phone":self.phoneTF!.text ?? "",
                     "email":self.mailTF!.text ?? "" ,
                     "weixin":self.weChatTF!.text ?? ""]
        
        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_FixInfo, parameters: param as? [String : String]) { (result) in
            do{
                let json = try JSON(data: result)
                if json["status"] == "200"{
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                    self.navigationController?.popViewController(animated: true)
                }else{
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                }
            }catch { }
        }
    }
    
    func fetchInfoData() {
        let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                     "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!)]
        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_GetInfo, parameters: param) { (result) in
            do{
                let json = try JSON(data: result)
                if json["status"].string == "200" {
                    if let url = URL(string: json["data"]["head_pic"].string ?? ""){
                        self.iconImageView?.kf.setImage(with: url)
                    }else{
                        self.iconImageView?.image = UIImage(named: "icon")
                    }
                    self.nameTF?.text    = json["data"]["username"].string ?? "用户名(测试)"
                    self.phoneTF?.text   = json["data"]["phone"].string ?? "手机号(测试)"
                    self.countryTF?.text = json["data"]["country"].string ?? "国家(测试)"
                    self.mailTF?.text    = json["data"]["email"].string ?? "邮箱(测试)"
                    self.weChatTF?.text  = json["data"]["wechat"].string ?? "微信(测试)"
                }else{
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                }
            }catch{ }
        }
    }
}

// ==============================================================================
// MARK: - UITableViewDelegate
// ==============================================================================
extension SX_MinePersonalController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text      = self.titleArr[indexPath.row]
        cell.textLabel?.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        cell.textLabel?.font      = UIFont.systemFont(ofSize: 16)
        cell.selectionStyle       = .none
        
        switch indexPath.row {
        case 0:
            self.iconImageView = UIImageView().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-30.FloatValue.IPAD_XValue)
                make.width.height.equalTo(60.FloatValue.IPAD_XValue)
            }).config({ (ICON) in
                ICON.layer.masksToBounds      = true
                ICON.layer.cornerRadius       = 30
            })
            
            return cell
            break
        case 1:
            self.nameTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (NAME) in
                NAME.keyboardType  = .namePhonePad
                NAME.placeholder   = "请输入姓名"
                NAME.textAlignment = .right
                NAME.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                NAME.font          = UIFont.systemFont(ofSize: 16)
            })
            
            return cell
            break
        case 2:
            
            self.phoneTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (PHONE) in
                PHONE.keyboardType  = .numberPad
                PHONE.placeholder   = "请输入手机号"
                PHONE.textAlignment = .right
                PHONE.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                PHONE.font          = UIFont.systemFont(ofSize: 16)
                PHONE.delegate      = self
            })
            
            return cell
            break
        case 3:
            self.countryTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (COUNTRY) in
                COUNTRY.keyboardType  = .namePhonePad
                COUNTRY.placeholder   = "请选择国家和地区"
                COUNTRY.textAlignment = .right
                COUNTRY.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                COUNTRY.font          = UIFont.systemFont(ofSize: 16)
                
            })
            
            return cell
            break
        case 4:
            self.weChatTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (WECHAT) in
                WECHAT.keyboardType  = .namePhonePad
                WECHAT.placeholder   = "请输入微信"
                WECHAT.textAlignment = .right
                WECHAT.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                WECHAT.font          = UIFont.systemFont(ofSize: 16)
            })
            
            return cell
            break
        case 5:
            self.mailTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (MAIL) in
                MAIL.keyboardType  = .namePhonePad
                MAIL.placeholder   = "请输入邮箱"
                MAIL.textAlignment = .right
                MAIL.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                MAIL.font          = UIFont.systemFont(ofSize: 16)
            })
            
            return cell
            break
        default :
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        
        self.saveBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (SAVE) in
            SAVE.setTitle("保存", for: .normal)
            SAVE.backgroundColor     = UIColor.colorWithHexString(hex: "666666", alpha: 1.0)
            SAVE.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
            SAVE.layer.masksToBounds = true
            SAVE.layer.cornerRadius  = 10
            
            SAVE.rx.tap.subscribe(onNext: { (_) in
                SXLog("保存个人信息")
                 self.fetchData()
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 10.FloatValue.IPAD_XValue
    }
}

// ==============================================================================
// MARK: - Other Method
// ==============================================================================
extension SX_MinePersonalController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.saveBtn?.resignFirstResponder()
    }
}

// ==============================================================================
// MARK: - UINavigationControllerDelegate
// ==============================================================================
extension SX_MinePersonalController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
}

// ==============================================================================
// MARK: - UIActionSheetDelegate
// ==============================================================================
extension SX_MinePersonalController: UIAlertViewDelegate {
    
    @objc func alterHeadPortrait() {
        
        let alert = UIAlertController(title: "提示", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "拍照", style: .default) { (Camera) in
            SXLog("相机 操作")
            let pickerImage = UIImagePickerController()
            pickerImage.sourceType = .camera
            pickerImage.allowsEditing = true
            pickerImage.delegate = self
        }
        
        let albunAction = UIAlertAction(title: "从相册选取", style: .default) { (Albun) in
            let pickerImage = UIImagePickerController()
            pickerImage.sourceType = .photoLibrary
            pickerImage.allowsEditing = true
            pickerImage.delegate = self
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Cancel) in
            self.present(alert, animated: true, completion: nil)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(albunAction)
        alert.addAction(cameraAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// ==============================================================================
// MARK: - KeyBoard Noti
// ==============================================================================
extension SX_MinePersonalController {
    @objc func keyBoardWillShow(noti: Notification) {
        self.table.frame = CGRect(x: 0, y: -100, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    @objc func keyBoardWillHidden() {
        self.table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
}

// ==============================================================================
// MARK: - UITextFieldDelegate
// ==============================================================================
extension SX_MinePersonalController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if  (range.length + range.location > textField.text!.length) {
            return false
        }
        
        let newLength = textField.text!.length + string.length - range.length
        if newLength <= 11 {
            return true
        }else{
            let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode       = .text
            hud.isSquare   = true
            hud.label.text = "手机号不能超过11位哦"
            hud.hide(animated: true, afterDelay: 1.0)
        }
        return false
    }
}


