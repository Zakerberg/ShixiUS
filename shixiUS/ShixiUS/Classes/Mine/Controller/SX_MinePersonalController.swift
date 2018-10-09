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
 我欠你一声温柔半世呵护
 分期一万年
 */

import UIKit
import SwiftyJSON

class SX_MinePersonalController: UIViewController {
    
    var titleArr   = ["头像", "用户名", "手机号", "国家/地区", "微信", "邮箱"]
    var contentArr = ["", "请输入姓名", "请输入手机号", "请选择国家和地区", "请输入微信", "请输入邮箱"]
    var getUrlDataArr: Array<Any>?
    var headPortrait: UIImage?
    var saveBtn: UIButton?
    var Dic = NSMutableDictionary(capacity: 10)
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        
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

// =============================================================================================
// MARK: - Other method
// ============================================================================================
extension SX_MinePersonalController {
    
    func setUI() {
        title = "个人信息"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.table)
    }
    
    func fetchData() {
        let param = ["headpic" :"1",
                     "username":self.Dic.value(forKey: "1"),
                     "country" :self.Dic.value(forKey: "3"),
                     "phone"   :self.Dic.value(forKey: "2"),
                     "email"   :self.Dic.value(forKey: "5"),
                     "weixin"  :self.Dic.value(forKey: "4")]
        
        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_FixInfo, parameters: param as? [String : String]) { (result) in
            do{
                let json = try JSON(data: result)
                
                
            }catch { }
        }
    }
}

// =============================================================================================
// MARK: - UITableViewDelegate
// =============================================================================================
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
        if indexPath.row == 0 {
            let singleTap = UIGestureRecognizer(target: self, action: #selector(alterHeadPortrait))
            let cell = SX_PersonalHeadPortraitCell(style: .default, reuseIdentifier: nil)
            
            cell.selectionStyle = .none
            cell.titleLabel?.text = self.titleArr[indexPath.row]
            cell.addGestureRecognizer(singleTap)
            
            return cell
        }else{
            
            let cell = SX_PersonalMessageCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            cell.titleLabel?.text = self.titleArr[indexPath.row]
            cell.tF?.placeholder  = self.contentArr[indexPath.row]
            
            
            
            cell.tF?.rx.controlEvent([.editingDidEnd,.editingChanged,.editingDidEnd]).asObservable().subscribe({ [weak self] (_) in
                self?.Dic.setValue((cell.tF?.text ?? "") , forKey: "\(indexPath.row)")
//                self?.Dic.addEntries(from: [(cell.tF?.text ?? ""):"\(indexPath.row)"])
            })
            
            return cell
        }
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
                
                self.navigationController?.popViewController(animated: true)
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

// =============================================================================================
// MARK: - Other Method
// =============================================================================================
extension SX_MinePersonalController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.saveBtn?.resignFirstResponder()
    }
}

// =============================================================================================
// MARK: - UINavigationControllerDelegate
// =============================================================================================
extension SX_MinePersonalController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
    }
}

// =============================================================================================
// MARK: - UIActionSheetDelegate
// =============================================================================================
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
