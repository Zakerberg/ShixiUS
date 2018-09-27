//
//  SX_MineVC.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的

/*
 北上看到的冰川是你,
 南下追寻的极光是你,
 西去流浪的经幡是你,
 东去皈依的佛经也是你.
 
 世 不 遇 你
 生 无 可 喜
 */

import UIKit

let mineCellID = "mineCellID"
let mineIconCellID = "mineIconCellID"

class SX_MineVC: UIViewController {
    
    var mineImageArr = [["te"], ["MyApply", "MyCollection"], ["PayRecord", "Personal"], ["FixPassword"]]
    var mineTitleArr = [["st"], ["我的申请", "我的收藏"], ["付费记录", "个人信息"], ["修改密码"]]
    var quitBtn: UIButton?
    
    var titleNameLabel: UILabel?
    var logInBtn: UIButton?
    var headPortraitImageView: UIImageView?
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled              = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName:  NSNotification.Name(rawValue: "REGISTRSUCCEED"), object: nil, queue: OperationQueue.main) { (text) in
            self.titleNameLabel?.text = "\(String(describing: text.userInfo?["text"]))"
        }
        
        setUI()
    }
}

// =================================================================================================================
// MARK: - Other Method
// =================================================================================================================
extension SX_MineVC {
    
    func setUI() {
        title = "我的"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
}

// =================================================================================================================
// MARK: -  UITableViewDelegate
// =================================================================================================================
extension SX_MineVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 3 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let tap = UITapGestureRecognizer(target: self, action: #selector(changeIconImageView))
            let cell = SX_HeadPortraitCell(style: .default, reuseIdentifier: mineIconCellID)
            cell.selectionStyle   = .none
            
            if USERDEFAULTS.object(forKey: "token") == nil { //未登录
                
            }else{
                cell.headPortraitImageView?.addGestureRecognizer(tap)
            }
            self.headPortraitImageView  = cell.headPortraitImageView
            self.titleNameLabel = cell.nameTitle
            
           if USERDEFAULTS.object(forKey: "token") == nil { //未登录
                cell.nameTitle?.isHidden = true
                cell.logInButton?.rx.tap.subscribe(onNext: { (_) in
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: {
                    })
                    
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
                
            }else{
                cell.logInButton?.isHidden = true
                cell.nameTitle?.isHidden = false
                cell.nameTitle?.text = self.titleNameLabel?.text
            }
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: mineCellID)
        cell.textLabel?.text  = self.mineTitleArr[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage.init(named: self.mineImageArr[indexPath.section][indexPath.row] )
        cell.accessoryType    = .disclosureIndicator
        cell.selectionStyle   = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 90.FloatValue.IPAD_XValue
        }
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 3 {
            return 45.FloatValue.IPAD_XValue
        }
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 3 {
            let view = UIView()
            
            self.quitBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview().offset(Margin)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(60.FloatValue.IPAD_XValue)
            }).config({ (QUIT) in
                QUIT.backgroundColor   = UIColor.white
                QUIT.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 18)
                QUIT.setTitle("退出登录", for: .normal)
                QUIT.setTitleColor(UIColor.SX_MainColor(), for: .normal)
                QUIT.rx.tap.subscribe(onNext: { (_) in
                    SXLog("退出登录 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.hidesBottomBarWhenPushed = true
                let vc = SX_MyApplyController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }else {
                SXLog("进入我的收藏Conroller")
                self.hidesBottomBarWhenPushed = true
                let vc = SX_MineMyCollectionController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                SXLog("进入付款记录Conroller")
                self.hidesBottomBarWhenPushed = true
                let vc = SX_PaymentRecordController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }else {
                SXLog("进入个人信息Conroller")
                self.hidesBottomBarWhenPushed = true
                let vc = SX_MinePersonalController()
                self.navigationController?.pushViewController(vc, animated: true)
                self.hidesBottomBarWhenPushed = false
            }
        } else {
            SXLog("进入修改密码Conroller")
            self.hidesBottomBarWhenPushed = true
            let vc = SX_MineFixPasswordController()
            self.navigationController?.pushViewController(vc, animated: true)
            self.hidesBottomBarWhenPushed = false
        }
    }
}

// =========================================================================================
// MARK: - Noti
// =========================================================================================
extension SX_MineVC {
    
    @objc func changeIconImageView(tap: UITapGestureRecognizer) {
        //底部弹出来个actionSheet来选择拍照或者相册选择
        let sheetAlert = UIAlertController(title: "选择上传类型", message: nil, preferredStyle: .actionSheet)
        let albumAction = UIAlertAction(title: "手机相册选择", style: .default) { (action) in
            SXLog("相册选择")
            //这里加一个判断，是否是来自图片库
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .savedPhotosAlbum
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        // 相机拍摄
        let photoAction = UIAlertAction(title: "相机拍摄", style: .default) { (ACTION) in
            SXLog("相机拍摄")
            if UIImagePickerController.isSourceTypeAvailable(.camera)  {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (cancel) in
            SXLog("取消")
        }
        
        sheetAlert.addAction(albumAction)
        sheetAlert.addAction(photoAction)
        sheetAlert.addAction(cancelAction)
        
        self.present(sheetAlert, animated: true, completion: nil)
    }
}

// =========================================================================================
// MARK: - UIImagePickerControllerDelegate , UINavigationControllerDelegate
// =========================================================================================
extension SX_MineVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let img = (info as NSDictionary).object(forKey: UIImagePickerControllerEditedImage)
        self.headPortraitImageView?.image = img as? UIImage
        let compressImg = imageWithImageSimple(img as! UIImage, newSize:CGSize(width: 60, height: 60))
        //   transportImgToServer(img: compressImg)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// =========================================================================================
// MARK: - 头像相关
// =========================================================================================
extension SX_MineVC {
    
    /// 图片压缩
    func imageWithImageSimple(_ img: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(newSize)
        img.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImg!
    }
    
    /// 上传到服务器
    func transportImgToServer(img: UIImage) {
        
        var imageData: Data
        var mineType: String
        
        if UIImagePNGRepresentation(img) != nil {
            mineType = "image/png"
            imageData = UIImagePNGRepresentation(img)!
        } else {
            mineType = "image/jpeg"
            imageData = UIImageJPEGRepresentation(img, 1.0)!
        }
        
        //        let iconStr = NSString(data: imageData, encoding: String.Encoding.utf8.rawValue)
        let dic = ["image":imageData]
        
    }
}
