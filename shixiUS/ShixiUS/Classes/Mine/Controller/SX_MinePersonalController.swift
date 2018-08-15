//
//  SX_MinePersonalController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息

import UIKit

class SX_MinePersonalController: UIViewController {
    
    var titleArr   = ["头像", "用户名", "手机号", "国家/地区", "微信", "邮箱"]
    var contentArr = ["", "请输入姓名", "请输入手机号", "请选择国家和地区", "请输入微信", "请输入邮箱"]
    var getUrlDataArr: Array<Any>?
    var headPortrait: UIImage?
    
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
        title = "个人信息"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        let tap = UIGestureRecognizer(target: self, action: #selector(selfInfoTapClick))
        // 默认 true
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.view.addSubview(self.table)
        setUI()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================================================================
// MARK: - Other method
// ===============================================================================================================================
extension SX_MinePersonalController {
    
    func setUI() {
//        let saveBtn = UIButton(type: .custom).addhere(toSuperView: self.table.tableFooterView!).layout { (make) in
//            
//            }.config { (Save) in
//                Save.backgroundColor = UIColor.SX_MainColor()
//                Save.layer.cornerRadius = 10.FloatValue.IPAD_XValue
//                Save.layer.masksToBounds = true
//                Save.rx.tap.subscribe(onNext: { (_) in
//                    SXLog("保存个人信息---")
//                    
//                    
//                }, onError: { (error) in
//                    SXLog(error)
//                }, onCompleted: nil, onDisposed: nil)
//        }
    }
    
    func fetchData() {
        
        
    }
}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
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
            
            let cell = SX_HeadPortraitCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.headPortraitImageView?.image = headPortrait
            cell.logInButton?.isHidden = true
            cell.nameTitle?.isHidden   = true
          //  cell.headPortraitImageView?.frame = CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            
            cell.addGestureRecognizer(singleTap)
            
            return cell
        }
        
        let cell = SX_PersonalMessageCell(style: .default, reuseIdentifier: nil)
        
        cell.titleLabel?.text = self.titleArr[indexPath.row]
        cell.tF?.placeholder  = self.contentArr[indexPath.row]
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ===============================================================================================================================
// MARK: - UITextFieldDelegate
// ===============================================================================================================================
extension SX_MinePersonalController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string == "\n" { // 按下return键
            textField.resignFirstResponder()
            self.table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            return true
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}


// ===============================================================================================================================
// MARK: - UIGestureRecognizerDelegate
// ===============================================================================================================================
extension SX_MinePersonalController: UIGestureRecognizerDelegate {
    
    @objc func selfInfoTapClick() {
        self.view.endEditing(true)
        self.table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
}

// ===============================================================================================================================
// MARK: - UINavigationControllerDelegate
// ===============================================================================================================================
extension SX_MinePersonalController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
//    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
//    //定义一个newPhoto，用来存放我们选择的图片。
//    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
//    _myHeadPortrait.image = newPhoto;
//    [self dismissViewControllerAnimated:YES completion:nil];
//    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let newPhoto = info.index(forKey: "UIImagePickerControllerEditedImage")
        
//      self.headPortrait = newPhoto
        self.dismiss(animated: true, completion: nil)
        
    }
}

// ===============================================================================================================================
// MARK: - UIActionSheetDelegate
// ===============================================================================================================================
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
