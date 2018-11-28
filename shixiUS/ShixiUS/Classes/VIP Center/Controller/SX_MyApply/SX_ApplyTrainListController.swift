//
//  SX_ApplyTrainListController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/5.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目的申请表

/*
 因为一个人，才爱上一座城
 我从你城门走过
 守城的卫士告诉我，在等黎明
 */


import UIKit
import SwiftyJSON
import MBProgressHUD

let applyListIdentifier = "applyListIdentifier"
let applyAddressCellID  = "applyAddressCellID"

class SX_ApplyTrainListController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 16)
    var confirmBtn: UIButton?
    
    var name: UITextField?
    var IDCard: UITextField?
    var education: UITextField?
    var school: UITextField?
    var company: UITextField?
    var telephone: UITextField?
    var wechat: UITextField?
    var country: UITextField?
    var email: UITextField?
    
    var visaStr: String?
    var gradStr: String?
    var number:String? /// 订单号
    
    /// 是否有签证Arr
    var VisaArr :Array = { () -> [[String : String]] in
        let arr1 = [["title":"有", "value":"1"],
                    ["title":"否", "value":"0"]]
        
        return arr1
    }()
    
    /// 是否毕业Arr
    var graduationArr: Array = { () -> [[String : String]] in
        let arr2 = [["title":"在校", "value":"1"],
                    ["title":"毕业", "value":"0"]]
        
        return arr2
    }()
    
    lazy var table: UITableView    = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor  = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate         = self
        tableView.dataSource       = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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
extension SX_ApplyTrainListController {
    
    func setUI() {
        title = "实训项目申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
        let param = ["token":String(describing: USERDEFAULTS.value(forKey: "token")!),
                     "userId":String(describing: USERDEFAULTS.value(forKey: "userId")!),
                     "training":"",
                     "details":"",
                     "telephone":self.telephone?.text ?? "",
                     "email":self.email?.text ?? "",
                     "wechat":self.wechat?.text ?? "",
                     "fullname":"",
                     "graduation":self.education?.text ?? "",
                     "school":self.school?.text ?? "",
                     "discipline":"",
                     "grade":"",
                     "us_visa":"",
                     "country":self.country?.text ?? "",
                     "address":"",
                     "promoter":""]
        
        SX_NetManager.requestData(type: .POST, URlString: SX_TrainingApply, parameters: param) { (result) in
        do {
            let json = try JSON(data: result)
            if json["status"].int == 200 {
                SXLog("申请成功")
                self.number = json["data"]["number"].string
            }
            }catch { }
        }
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyTrainListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 { /// 标题: 全球公民学院
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            cell.textLabel?.text          = "全球公民学院"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font          = UIFont.boldSystemFont(ofSize: 16)
            cell.textLabel?.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            
            return cell
        }else if indexPath.row == 5 || indexPath.row == 6 { // 单选按钮cell (是否有签证)
            let cell = SX_ApplyVisaCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            if indexPath.row == 5 {
                cell.title?.text = "是否有美国签证"
                for index in 0...1 {
                    let _ = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout { (make) in
                        make.centerY.equalToSuperview()
                        make.width.equalTo(60.FloatValue.IPAD_XValue)
                        make.height.equalTo(28.FloatValue.IPAD_XValue)
                        make.left.equalTo(cell.title!.snp.right).offset(CGFloat(index) * 80.FloatValue.IPAD_XValue + 10.FloatValue.IPAD_XValue)
                        }.config { (BTN) in
                            BTN.setTitle(self.VisaArr[index]["title"], for: .normal)
                            BTN.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                            BTN.setTitleColor(UIColor.SX_MainColor(), for: .selected)
                            BTN.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                            BTN.titleLabel?.font          = UIFont.systemFont(ofSize: 13)
                            BTN.titleLabel?.textAlignment = .center
                            BTN.tag                       = index+1000
                            BTN.layer.cornerRadius        = 5
                            BTN.layer.borderColor         = UIColor.init(white: 0.6, alpha: 1).cgColor
                            BTN.layer.borderWidth         = 0.6
                            if index == 0{
                                BTN.isSelected            = true
                                BTN.layer.borderColor     = UIColor.SX_MainColor().cgColor
                            }
                            
                            BTN.addTarget(self, action: #selector(BtnClick), for: .touchUpInside)
                    }
                }
            } else if indexPath.row == 6 {
                cell.title?.text = "是否在校"
                for index in 0...1 {
                    let _ = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout { (make) in
                        make.centerY.equalToSuperview()
                        make.width.equalTo(60.FloatValue.IPAD_XValue)
                        make.height.equalTo(28.FloatValue.IPAD_XValue)
                        make.left.equalTo(cell.title!.snp.right).offset(CGFloat(index) * 80.FloatValue.IPAD_XValue + 10.FloatValue.IPAD_XValue)
                        }.config { (BTN) in
                            BTN.setTitle(self.graduationArr[index]["title"], for: .normal)
                            BTN.setTitleColor(UIColor.SX_MainColor(), for: .selected)
                            BTN.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                            BTN.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                            BTN.titleLabel?.font          = UIFont.systemFont(ofSize: 13)
                            BTN.titleLabel?.textAlignment = .center
                            BTN.tag                       = index+2000
                            BTN.layer.cornerRadius        = 5
                            BTN.layer.borderColor         = UIColor.init(white: 0.6, alpha: 1).cgColor
                            BTN.layer.borderWidth         = 0.6
                            if index == 0{
                                BTN.isSelected            = true
                                BTN.layer.borderColor     = UIColor.SX_MainColor().cgColor
                            }
                            
                            BTN.addTarget(self, action: #selector(graduationBtnClick), for: .touchUpInside)
                    }
                }
            }
            
            return cell
            
        } else if indexPath.row == 2 { // 国家选择
            let cell = SX_ApplyAddressCell(style: .default, reuseIdentifier: applyAddressCellID)
            cell.selectionStyle = .none
            
            cell.title?.text    = "所在国家"
            
            cell.addressBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("地址选择")
                let addressPicker = SX_AddressViewController()
                addressPicker.view.backgroundColor         = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                // 返回选择数据,地址,省,市,区
                addressPicker.backLocationStringController = { (address,province,city,area) in
                    cell.addressBtn?.setTitle(address, for: .normal)
                }
                self.present(addressPicker, animated: true, completion: nil)
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            
            return cell
        } else if indexPath.row == 13 || indexPath.row == 14 { // 上传简历 & 求职信
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle  = .none
            cell.textLabel?.text = "上传简历"
            
            return cell
        } else {
            let cell = SX_ApplyMessageCell(style: .default, reuseIdentifier: applyListIdentifier)
            cell.selectionStyle            = .none
            
            switch indexPath.row {
            case 1:
                cell.title?.text           = "姓名"
                cell.TF?.placeholder       = "输入您的姓名"
                
                break
            case 3:
                cell.title?.text           = "手机"
                cell.TF?.placeholder       = "输入您的手机号"
                cell.TF?.keyboardType      = .phonePad
                
                break
            case 4:
                cell.title?.text           = "邮箱"
                cell.TF?.placeholder       = "输入您的邮箱"
                
                break
            case 7:
                cell.title?.text           = "微信"
                cell.TF?.placeholder       = "输入您的微信"
                
                break
            case 8:
                cell.title?.text           = "年龄"
                cell.TF?.placeholder       = "输入您的年龄"
                
                break
            case 9:
                cell.title?.text           = "学校"
                cell.TF?.placeholder       = "输入您的学校"
                
                break
            case 10:
                cell.title?.text           = "专业"
                cell.TF?.placeholder       = "输入您的专业"
                
                break
            case 11:
                cell.title?.text           = "年级"
                cell.TF?.placeholder       = "输入您的年级"
                
                break
            case 12:
                cell.title?.text           = "地址"
                cell.TF?.placeholder       = "输入您的地址(例如: 北京东城区)"
                
                break
            case 15:
                cell.title?.text           = "推荐人"
                cell.TF?.placeholder       = "输入推荐人"
                
                break
            default:
                break
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        self.confirmBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (CONFIRM) in
            CONFIRM.backgroundColor     = UIColor.SX_MainColor()
            CONFIRM.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
            CONFIRM.setTitle("确定", for: .normal)
            CONFIRM.layer.masksToBounds = true
            CONFIRM.layer.cornerRadius  = 10
            CONFIRM.rx.tap.subscribe(onNext: { (_) in
                SXLog("确定申请 +++ + ")
                
                /// 申请成功 ! 获取订单号
                
                
                
                
                
                
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.FloatValue.IPAD_XValue
    }
}

// ========================================================================
// MARK: - @objc
// ========================================================================
extension SX_ApplyTrainListController {
    @objc func BtnClick(btn: UIButton) {
        for index in 0...1 {
            let button = self.view.viewWithTag(1000+index) as? UIButton
            
            if button?.tag != btn.tag {
                button?.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
                button?.layer.borderWidth = 0.6
                button?.isSelected        = false
            }else{
                button?.layer.borderColor = UIColor.SX_MainColor().cgColor
                button?.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                button?.layer.borderWidth = 0.6
                button?.isSelected        = true
                let dic = self.VisaArr[index] as [String:String]
                self.visaStr = dic["value"]
                SXLog(visaStr)
            }
        }
    }
    
    @objc func graduationBtnClick(btn: UIButton) {
        for index in 0...1 {
            let button = self.view.viewWithTag(2000+index) as? UIButton
            
            if button?.tag != btn.tag {
                button?.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
                button?.layer.borderWidth = 0.6
                button?.isSelected        = false
            }else{
                button?.layer.borderColor = UIColor.SX_MainColor().cgColor
                button?.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                button?.layer.borderWidth = 0.6
                button?.isSelected        = true
                let dic = self.graduationArr[index] as [String:String]
                self.gradStr = dic["value"]
                SXLog(gradStr)
            }
        }
    }
}
