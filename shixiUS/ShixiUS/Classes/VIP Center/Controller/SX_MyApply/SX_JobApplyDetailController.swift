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

class SX_JobApplyDetailController: SX_BaseController {
    
    var detailPriceLabel: UILabel?  // 价格
    var payBtn: UIButton? // 支付服务预定金
    var cancelBtn: UIButton? // 取消订单
    var number: String?
    var statusBtn: UIButton? // 状态(申请退款Btn)
    
    var jobApplyDetail = JSON()
    var applyStatus:String?
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
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
        title = "申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let url = SX_ApplyJobDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"
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
        if section == 2 {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.jobApplyDetail[indexPath.row]
        if indexPath.section == 0 {
            let cell  = SX_ApplyProgressCell(style: .default, reuseIdentifier: nil)
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
            
            cell.employmentTitle?.text              = model["title"].string ?? "美国金融实习岗位-信托和过桥基金业务(测试)"
            cell.employmentDate?.text               = model["addtime"].string ?? "2018.03.03(测试)"
            cell.employmentAddress?.text            = model["address"].string ?? "美国/纽约(测试)"
            cell.employmentNature?.text             = model["nature"].string ?? "正式(测试)"
            
            return cell
        }else{
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: detailCellID)
            cell.backgroundColor  = UIColor.white
            cell.selectionStyle   = .none
            
            self.detailPriceLabel = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (PRICE) in
                PRICE.sizeToFit()
            })
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text                = "美国金融实习岗位"
                cell.textLabel?.font                = UIFont.systemFont(ofSize: 16)
                cell.textLabel?.textColor           = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
                
            case 1:
                cell.textLabel?.text                = "服务费用总额"
                cell.textLabel?.font                = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor           = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.detailPriceLabel?.text         = "¥500.00"
                self.detailPriceLabel?.font         = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor    = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 2:
                cell.textLabel?.text                = "预定金"
                cell.textLabel?.font                = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor           = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.detailPriceLabel?.text         = "¥100.00"
                self.detailPriceLabel?.font         = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor    = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 3:
                cell.textLabel?.text                = "状态"
                cell.textLabel?.font                = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor           = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.statusBtn = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                    make.centerY.equalToSuperview()
                    make.height.equalTo(30.FloatValue.IPAD_XValue)
                    make.right.equalToSuperview().offset(-Margin)
                }).config({ (STATUSBTN) in
                    STATUSBTN.backgroundColor       = UIColor.SX_MainColor()
                    STATUSBTN.titleLabel?.font      = UIFont.boldSystemFont(ofSize: 12)
                    STATUSBTN.setTitle((model["steps"].string ?? ""), for: .normal)
                    STATUSBTN.setTitleColor(UIColor.white, for: .normal)
                    STATUSBTN.isHidden              = true
                })
                
                self.detailPriceLabel?.text         = "未支付"
                self.detailPriceLabel?.font         = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor    = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 4:
                cell.textLabel?.text                = "应付定金"
                cell.textLabel?.font                = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor           = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                self.detailPriceLabel?.text         = "¥100.00"
                self.detailPriceLabel?.font         = UIFont.boldSystemFont(ofSize: 18)
                self.detailPriceLabel?.textColor    = UIColor.colorWithHexString(hex: "fc1614", alpha: 1)
                
                break
            default:
                break
            }
            return cell
        }
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
                return UILabel.SX_getSpaceLabelHeight((model["stepsCn"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
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
            return 120.FloatValue.IPAD_XValue
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
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

