//
//  SX_JobApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情 --> (就业岗位)

/*
 听过最撩人的一句话:
 我之前没有爱过别人
 你是第一个
 我怕我做的不好
 让你觉得
 爱情不过如此
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

let applyDetailCellID = "applyDetailCellID"
let detailCellID      = "detailCellID"

class SX_JobApplyDetailController: UIViewController {
    
    var payBtn: UIButton? // 支付服务预定金
    var cancelBtn: UIButton? // 取消订单
    var number: String?
    var statusBtn: UIButton? // 状态(申请退款Btn)
    
    var jobApplyDetail = JSON()
    var applyStatus:String?
    var sectionArr = ["", "服务费用总额", "预定金", "状态", "应付定金"]
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate        = self
        tableView.dataSource      = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
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
extension SX_JobApplyDetailController {
    
    func setUI() {
        title = "就业申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let url = SX_ApplyJobDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"
        /*
         状态字段status
         0:申请成功;1:就业顾问联系;2:应聘成功;3:申请退款;4:审核通过;
         5:审核驳回;6:退款完成;7:取消申请
         */
        SX_NetManager.requestData(type: .GET, URlString: url, parameters:  nil, finishCallBack: { (result) in
            do{
                let json = try JSON(data: result)
                self.jobApplyDetail = JSON(arrayLiteral: json["data"].dictionary ?? [:])
                self.applyStatus    = json["data"]["status"].string ?? ""
            } catch{ }
            
            self.table.reloadData()
        })
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_JobApplyDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.applyStatus == "0" {
            return 2
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }else{
            if self.applyStatus == "7" {
                return 4
            }else{
                return 5
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.jobApplyDetail[indexPath.row]
        if indexPath.section == 0 {
            let cell  = SX_ApplyProgressCell(style: .default, reuseIdentifier: "ApplyProgressCellID")
            cell.selectionStyle                     = .none
            
            if self.applyStatus == "7" { // 订单已经取消
                cell.progressNormalBgView?.isHidden = true
                cell.progressBgView?.isHidden       = false
                cell.progressBtn?.isHidden          = true
                cell.progressRejected?.text         = model["steps"].string ?? "测试订单取消"
            }else {
                cell.accessoryType                  = .disclosureIndicator
                cell.progressNormalBgView?.isHidden = false
                cell.progressBgView?.isHidden       = true
                cell.progressStep?.text             = model["steps"].string ?? "测试进度标题"
                cell.progressStatus?.text           = model["stepsCn"].string ?? "测试申请进度测试"
            }
            return cell
        } else if indexPath.section == 1 {
            
            let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: applyDetailCellID)
            cell.backgroundColor                    = UIColor.white
            cell.selectionStyle                     = .none
            cell.lineView?.isHidden                 = true
            cell.employmentDetail?.isHidden         = true
            cell.employmentNotiBtn?.isHidden        = true
            cell.employmentPay?.isHidden            = true
            
            cell.employmentTitle?.text              = model["title"].string ?? "美国金融实习岗位-信托和过桥基金业务(测试)"
            cell.employmentDate?.text               = model["addtime"].string ?? "2018.03.03(测试)"
            cell.employmentAddress?.text            = model["address"].string ?? "美国/纽约(测试)"
            cell.employmentNature?.text             = model["nature"].string ?? "正式(测试)"
            
            return cell
        }
        
        let cell = SX_ApplyDetailMessageCell(style: .default, reuseIdentifier: "ApplyDetailMessageCellID")
        let messModel = self.jobApplyDetail[0]
        cell.backgroundColor      = UIColor.white
        cell.selectionStyle       = .none
        
        switch indexPath.row {
        case 1:
            cell.title?.text      = self.sectionArr[indexPath.row]
            cell.title?.font      = UIFont.systemFont(ofSize: 14)
            cell.title?.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            cell.price?.text      =  "¥" + (messModel["serviceMoney"].string ?? "11.11(测试服务费)")
            break
        case 2:
            cell.title?.text      = self.sectionArr[indexPath.row]
            cell.title?.font      = UIFont.systemFont(ofSize: 14)
            cell.title?.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            cell.price?.text      = "¥" + (messModel["deposit"].string ?? "11.11(测试)")
            break
        case 3:
            cell.title?.text      = self.sectionArr[indexPath.row]
            cell.title?.font      = UIFont.systemFont(ofSize: 14)
            cell.title?.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            if self.applyStatus   == "7" {
                cell.price?.textColor = UIColor.colorWithHexString(hex: "fc1614", alpha: 1)
            }
            cell.price?.text      = messModel["steps"].string ?? "测试订单取消"
            break
        case 4:
            cell.title?.text      = self.sectionArr[indexPath.row]
            cell.title?.font      = UIFont.boldSystemFont(ofSize: 16)
            cell.title?.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            
            cell.price?.font      = UIFont.boldSystemFont(ofSize: 18)
            cell.price?.textColor = UIColor.colorWithHexString(hex: "fc1614", alpha: 1)
            cell.price?.text      = "¥" + (messModel["deposit"].string ?? "11.11(测试)")
            break
        default: // 0
            cell.title?.text      = model["title"].string ?? "美国金融实习岗位-信托和过桥基金业务(测试)"
            cell.title?.font      = UIFont.boldSystemFont(ofSize: 16)
            cell.title?.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 2 {
            let view = UIView()
            self.payBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview().offset(Margin)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(50.FloatValue.IPAD_XValue)
            }).config({ (PAY) in
                PAY.backgroundColor     = UIColor.SX_MainColor()
                PAY.layer.masksToBounds = true
                PAY.layer.cornerRadius  = 5
                PAY.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 18)
                PAY.setTitle("支付服务预定金", for: .normal)
                PAY.setTitleColor(UIColor.white, for: .normal)
                if self.applyStatus == "2" || self.applyStatus == "3" || self.applyStatus == "4" || self.applyStatus == "5" || self.applyStatus == "6" || self.applyStatus == "7" { //对应图34578
                    PAY.isHidden = true
                }
                
                PAY.rx.tap.subscribe(onNext: { (_) in
                    SXLog("支付服务预定金 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            self.cancelBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.payBtn!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.height.left.right.equalTo(self.payBtn!)
            }).config({ (CANCEL) in
                CANCEL.backgroundColor     = UIColor.colorWithHexString(hex: "cccccc", alpha: 1)
                CANCEL.layer.masksToBounds = true
                CANCEL.layer.cornerRadius  = 5
                CANCEL.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 18)
                CANCEL.setTitle("取消订单", for: .normal)
                CANCEL.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                if self.applyStatus == "1" {
                    CANCEL.isHidden = false
                }else{
                    CANCEL.isHidden = true // 对应图1345678
                }
                CANCEL.rx.tap.subscribe(onNext: { (_) in
                    SXLog("取消订单 +++ + ")
                
                    
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.jobApplyDetail[indexPath.section]
        if indexPath.section == 0 {
            if self.applyStatus == "7" { // 订单已经取消
                return 100.FloatValue.IPAD_XValue
            }else{
                return UILabel.SX_getSpaceLabelHeight((model["stepsCn"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 80.FloatValue.IPAD_XValue
            }
        } else if indexPath.section == 1{
            return 70.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            if self.applyStatus == "7" {
                return 5.FloatValue.IPAD_XValue
            }else{
                return 120.FloatValue.IPAD_XValue
            }
        }
        return 5.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            SXLog("进入申请进度详情界面")
            let vc = SX_ApplyProgressDetailController()
            vc.typeStr = "job"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
