//
//  SX_ApplyEmpListController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/5.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  就业岗位(热门职位)的申请表

/*
 至死不渝的誓言最深情
 天荒地老的许诺最浪漫
 而我只想，陪你走过白发苍苍的平淡
 */

import UIKit
import MBProgressHUD
import SwiftyJSON

class SX_ApplyEmpListController: UIViewController {
    
    var applyBtn: UIButton?
    var numTF: UITextField?
    var weChatTF: UITextField?
    var jobid:String?
    
    //    var resumeController: UIDocumentBrowserViewController?
    var resumeBtn: UIButton?
    var letterBtn: UIButton? //求职信
    
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
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_ApplyEmpListController {
    
    func setUI() {
        title = "就业岗位申请"
        self.view.addSubview(table)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.numTF?.resignFirstResponder()
        self.weChatTF?.resignFirstResponder()
        self.applyBtn?.resignFirstResponder()
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyEmpListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text          = "请填写以下信息申请职位"
            cell.selectionStyle           = .none
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        if indexPath.row == 1 {
            
            cell.textLabel?.text = "手机号:"
            self.numTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (NUM) in
                NUM.tintColor     = UIColor.SX_MainColor()
                NUM.textAlignment = .left
                NUM.placeholder   = "请输入手机号"
                NUM.keyboardType  = .numberPad
                NUM.maxTextNumber = 11
                NUM.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                    SXLog("开始编辑手机号....")
                    
                    if ((self?.numTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.weChatTF?.text?.lengthOfBytes(using: .utf8)) != 0) {
                        self?.applyBtn?.isEnabled       = true
                        self?.applyBtn?.backgroundColor = UIColor.SX_MainColor()
                    }else{
                        self?.applyBtn?.isEnabled       = false
                        self?.applyBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                    }
                })
            })
            
        }else if indexPath.row == 2 {
            
            cell.textLabel?.text     = "微信号:"
            self.weChatTF = UITextField().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (WECHAT) in
                WECHAT.tintColor     = UIColor.SX_MainColor()
                WECHAT.textAlignment = .left
                WECHAT.placeholder   = "请输入微信号"
                WECHAT.rx.controlEvent(.editingChanged).asObservable().subscribe({ [weak self] (_) in
                    SXLog("开始编辑微信....")
                    
                    if ((self?.numTF?.text?.lengthOfBytes(using: .utf8)) != 0 && (self?.weChatTF?.text?.lengthOfBytes(using: .utf8)) != 0) {
                        self?.applyBtn?.isEnabled       = true
                        self?.applyBtn?.backgroundColor = UIColor.SX_MainColor()
                    }else{
                        self?.applyBtn?.isEnabled       = false
                        self?.applyBtn?.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
                    }
                })
            })
            
        }else if indexPath.row == 3 {
            
            cell.textLabel?.text = "上传简历:"
            self.resumeBtn = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.left.equalToSuperview().offset(115.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(30.FloatValue.IPAD_XValue)
                make.width.equalTo(150.FloatValue.IPAD_XValue)
            }).config({ (RESUME) in
                RESUME.setTitle("点击选取", for: .normal)
                RESUME.titleLabel?.textAlignment = .center
                RESUME.backgroundColor           = UIColor.SX_MainColor()
                RESUME.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 15)
                RESUME.layer.masksToBounds       = true
                RESUME.layer.cornerRadius        = 10
                
                RESUME.rx.tap.subscribe(onNext: { (_) in
                    SXLog("点击选取简历")
                    let vc = UIDocumentPickerViewController(documentTypes: ["public.content","public.text","public.source-code","public.image","public.audiovisual-content","com.adobe.pdf","com.apple.keynote.key","com.microsoft.word.doc","com.microsoft.excel.xls","com.microsoft.powerpoint.ppt"], in: UIDocumentPickerMode.open)
                    vc.delegate = self
                    vc.modalPresentationStyle = .fullScreen
                    
                    self.present(vc, animated: true, completion: {
                        
                        SXLog("选取文件1")
                        RESUME.setTitle("已经选取简历文件\(vc.allowsMultipleSelection)", for: .normal)
                        
                    })
                    
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
        }else if indexPath.row == 4 {
            
            cell.textLabel?.text = "上传求职信:"
            self.letterBtn = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.left.equalToSuperview().offset(115.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(30.FloatValue.IPAD_XValue)
                make.width.equalTo(150.FloatValue.IPAD_XValue)
            }).config({ (LETTER) in
                LETTER.setTitle("点击选取", for: .normal)
                LETTER.titleLabel?.textAlignment = .center
                LETTER.backgroundColor           = UIColor.SX_MainColor()
                LETTER.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 15)
                LETTER.layer.masksToBounds       = true
                LETTER.layer.cornerRadius        = 10
                LETTER.rx.tap.subscribe(onNext: { (_) in
                    SXLog("点击选取求职信")
                }, onError: { (error) in
                    
                }, onCompleted: nil, onDisposed: nil)
            })
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 40.FloatValue.IPAD_XValue
        }
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        self.applyBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (APPLY) in
            APPLY.backgroundColor     = UIColor.colorWithHexString(hex: "cccccc", alpha: 1.0)
            APPLY.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
            APPLY.setTitle("立即申请", for: .normal)
            APPLY.isEnabled           = false
            APPLY.layer.masksToBounds = true
            APPLY.layer.cornerRadius  = 10
            APPLY.rx.tap.subscribe(onNext: { (_) in
                SXLog("岗位就业申请表的立即申请 +++ + ")
                
                /// 封装的正则在这里! ! ! SX_Regex
                let pattern  = "^1(3[0-9]|4[57]|5[0-35-9]|6[6]|7[05-8]|8[0-9]|9[89])\\d{8}$"
                let regex    = try! SX_Regex(pattern)
                if regex.matches(self.numTF!.text!) {
                    SXLog("正确, 申请")
                    
                    let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                                 "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!),
                                 "job":self.jobid!,
                                 "telephone":self.numTF!.text!,
                                 "wechat":self.weChatTF!.text!
                        ] as [String : String]
                    
                    SX_NetManager.requestData(type: .POST, URlString: SX_Oversea_Apply_Confirm, parameters: param, finishCallBack: { (result) in
                        do{
                            let json = try JSON(data: result)
                            if json["status"].int == 200 {
                                SXLog("申请成功!")
                                let vc           = SX_ApplySucceedController()
                                vc.ApplyNum      = json["data"]["number"].string
                                self.navigationController?.pushViewController(vc, animated: true)
                            }else{ // 申请失败
                                let hud          = MBProgressHUD.showAdded(to: self.view, animated: true)
                                hud.mode         = .text
                                hud.isSquare     = true
                                hud.label.text   = json["msg"].string
                                hud.hide(animated: true, afterDelay: 1.0)
                            }
                        }catch{ }
                    })
                    
                }else{
                    SXLog("手机号格式错误")
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = "手机号格式错误"
                    hud.hide(animated: true, afterDelay: 2.0)
                }
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ========================================================================
// MARK: - UIDocumentPickerDelegate
// ========================================================================
extension SX_ApplyEmpListController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        SXLog(urls)
        
        let fileUrAuthoized: Bool = (urls.first?.startAccessingSecurityScopedResource())!
        if fileUrAuthoized {
            // 通过文件协调工具来得到新的文件地址, 以此得到文件的保护功能
            let fileCoordinator = NSFileCoordinator()
            fileCoordinator.coordinate(readingItemAt: urls.first!, options: [], error: nil) { (newURL) in
                let fileName = newURL.lastPathComponent
                let error:NSError? = nil
                do{
                    let fileData = try NSData(contentsOf: newURL, options: NSData.ReadingOptions.mappedIfSafe)
                    if (error != nil) {
                        // 读取出错
                        SXLog("读取出错")
                    }else{
                        // 上传
                        SXLog("上传")
//                        let str = try String(contentsOf: urls[0])
                        SX_NetManager.requestData(type: .POST, URlString: SX_Mine_UploadFile, parameters: ["file":"/private/var/mobile/Library/Mobile%20Documents/com~apple~CloudDocs/%E5%AE%9E%E8%AE%ADAPP1.0%E6%8E%A5%E5%8F%A3%E6%96%87%E6%A1%A3.doc"
                            ], finishCallBack: { (result) in
                                SXLog("这里打印 --------> \(result)")
                                
                        })
                        
                    }
                    self.dismiss(animated: true, completion: nil)
                }catch { }
                urls.first?.stopAccessingSecurityScopedResource()
            }
        }else{
            // 授权失败
            SXLog("授权失败")
        }
    }
}


// ========================================================================
// MARK: -
// ========================================================================
extension SX_ApplyEmpListController {
    
    
    
    
    
}


