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

class SX_MinePersonalController: UIViewController {
    
    var titleArr   = ["头像", "用户名", "手机号", "国家/地区", "微信", "邮箱"]
    var contentArr = ["", "请输入姓名", "请输入手机号", "请选择国家和地区", "请输入微信", "请输入邮箱"]
    var getUrlDataArr: Array<Any>?
    var headPortrait: UIImage?
    var saveBtn: UIButton?
    
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
        fetchData()
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
        let tap = UIGestureRecognizer(target: self, action: #selector(selfInfoTapClick))
        // 默认 true
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        self.view.addSubview(self.table)
    }
    
    func fetchData() {
        
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
            cell.textLabel?.text = "头像"
            
            cell.selectionStyle = .none
            cell.headPortraitImageV?.image = headPortrait
            
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
        let view = UIView()
        
        self.saveBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (SAVE) in
            SAVE.backgroundColor     = UIColor.SX_MainColor()
            SAVE.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
            SAVE.setTitle("保存", for: .normal)
            SAVE.layer.masksToBounds = true
            SAVE.layer.cornerRadius  = 10
            SAVE.rx.tap.subscribe(onNext: { (_) in
                SXLog("保存个人信息 +++ + ")
                /// 加提示 !
                
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
}

// =============================================================================================
// MARK: - UITextFieldDelegate
// =============================================================================================
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

// =============================================================================================
// MARK: - UIGestureRecognizerDelegate
// =============================================================================================
extension SX_MinePersonalController: UIGestureRecognizerDelegate {
    
    @objc func selfInfoTapClick() {
        self.view.endEditing(true)
        self.table.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
}

// =============================================================================================
// MARK: - UINavigationControllerDelegate
// =============================================================================================
extension SX_MinePersonalController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    //    - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //    //定义一个newPhoto，用来存放我们选择的图片。
    //    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    //    _myHeadPortrait.image = newPhoto;
    //    [self dismissViewControllerAnimated:YES completion:nil];
    //    }
    
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
