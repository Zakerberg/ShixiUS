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
import SwiftyJSON
import MBProgressHUD

let mineCellID     = "mineCellID"
let mineIconCellID = "mineIconCellID"

class SX_MineVC: UIViewController {
    
    var mineImageArr = [["te"], ["MyCollection","PayRecord"], ["Personal","FixPassword"]]
    var mineTitleArr = [["st"], ["我的收藏","付费记录"], ["个人信息","修改密码"]]
    
    var titleNameLabel: UILabel?
    var logInBtn: UIButton?
    var headPortraitImageView: UIImageView?
    var statusStr = ""
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled              = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
        return tableView
    }()
    
    lazy var quitBtn: UIButton = {
        let button = UIButton(type: .custom).addhere(toSuperView: table).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(385.FloatValue.IPAD_XValue)
            make.width.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (QUIT) in
            QUIT.backgroundColor   = UIColor.white
            QUIT.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 18)
            QUIT.setTitle("退出登录", for: .normal)
            QUIT.isHidden          = true
            QUIT.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            QUIT.rx.tap.subscribe(onNext: { (_) in
                SXLog("退出登录")
                let alertController = UIAlertController(title: "确定退出登录?", message: "", preferredStyle: .alert)
                
                var cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: { (_) in
                    
                })
                
                //[cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"]
                var sureAction  = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                    let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                                 "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!)]
                    SX_NetManager.requestData(type: .POST, URlString: SX_Mine_SignOut, parameters: param) { (result) in
                        do{
                            let json = try JSON(data: result)
                            if json["status"].int == 200 {
                                QUIT.isHidden                 = true
                                self.titleNameLabel?.isHidden = true
                                self.logInBtn?.isHidden       = false
                                USERDEFAULTS.set("", forKey: "token")
                                USERDEFAULTS.set("", forKey: "userId")
                                USERDEFAULTS.set("no", forKey: "login")
                                let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                hud.mode       = .text
                                hud.isSquare   = true
                                hud.label.text = json["msg"].string
                                hud.hide(animated: true, afterDelay: 1.0)
                            }else{
                                let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                hud.mode       = .text
                                hud.isSquare   = true
                                hud.label.text = json["msg"].string
                                hud.hide(animated: true, afterDelay: 1.0)
                            }
                        }catch { }
                    }
                })
                
                alertController.addAction(cancelAction)
                alertController.addAction(sureAction)
                self.present(alertController, animated: true, completion: nil)
                
            }, onError: { (error) in
                
            }, onCompleted: nil, onDisposed: nil)
        })
        return button
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Noti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

// ================================================================================
// MARK: - Other Method
// ================================================================================
extension SX_MineVC {
    
    func setUI() {
        title = "我的"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        table.addSubview(quitBtn)
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                     "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!)]
        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_GetInfo, parameters: param) { (result) in
            do{
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    self.titleNameLabel?.text = json["data"]["username"].string ?? "实习网(测试)"
                    if let url = URL(string: json["data"]["head_pic"].string ?? ""){
                        self.headPortraitImageView?.kf.setImage(with: url)
                    }else{
                        self.headPortraitImageView?.image = UIImage(named: "icon")
                    }
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = "登录成功"
                    hud.hide(animated: true, afterDelay: 1.0)
                }else {
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                }
            }catch { }
        }
    }
}

// ================================================================================
// MARK: -  UITableViewDelegate
// ================================================================================
extension SX_MineVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.mineImageArr.count
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
            cell.selectionStyle         = .none
            cell.nameTitle?.isHidden    = true
            cell.headPortraitImageView?.addGestureRecognizer(tap)
            self.headPortraitImageView  = cell.headPortraitImageView
            self.titleNameLabel         = cell.nameTitle
            self.logInBtn               = cell.logInButton
            
            self.logInBtn?.rx.tap.subscribe(onNext: { (_) in
                let vc = SX_LoginController()
                // 闭包回掉在这里!
                vc.callBack(closure: { (name, status) in
                    self.statusStr = status
                    if self.statusStr == "1" { // 登陆
                        self.titleNameLabel?.isHidden = false
                        self.logInBtn?.isHidden       = true
                    }
                })
                self.present(vc, animated: true, completion: nil)
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
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
        if section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 5.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    SXLog("进入我的收藏Conroller")
                    self.hidesBottomBarWhenPushed = true
                    let vc = SX_MineMyCollectionController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            }else {
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    SXLog("进入付款记录Conroller")
                    self.hidesBottomBarWhenPushed = true
                    let vc = SX_PaymentRecordController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            }
        } else if indexPath.section == 2 {
            if indexPath.row == 0 {
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    SXLog("进入个人信息Conroller")
                    self.hidesBottomBarWhenPushed = true
                    let vc = SX_MinePersonalController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            }else {
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    SXLog("进入修改密码Conroller")
                    self.hidesBottomBarWhenPushed = true
                    let vc = SX_MineFixPasswordController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.hidesBottomBarWhenPushed = false
                }
            }
        }
    }
}

// =========================================================================================
// MARK: -
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
        
        //  let iconStr = NSString(data: imageData, encoding: String.Encoding.utf8.rawValue)
        let dic = ["image":imageData]
    }
}

// =========================================================================================
// MARK: - Noti
// =========================================================================================
extension SX_MineVC {
    func Noti() {
        NotificationCenter.default.rx.notification(NSNotification.Name(rawValue: "LOGINSUCCESS")).takeUntil(self.rx.deallocated).subscribe(onNext: { (noti) in
            self.titleNameLabel?.isHidden = false
            self.logInBtn?.isHidden       = true
            // self.titleNameLabel?.text     = (noti.userInfo?["name"] ?? "暂未设置") as? String
            self.quitBtn.isHidden         = false
            self.fetchData()
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
    }
}

