//
//  SX_TrainingApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/30.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情 --> (实训项目)

/*
 在没有你的世界里
 任何愿望都无法实现
 宇多田光 -- <<镰仓物语>> 电影主题曲
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_TrainingApplyDetailController: SX_BaseController {
    
    var number: String?
    var applyStatus:String?
    var payBtn: UIButton? // 去支付
    var cancelBtn: UIButton? // 取消订单
    var refundBtn: UIButton? // 申请退款(取消退款)
    
    var trainingApplyDetail = JSON()
    
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
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================
// MARK: - Other Method
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    func setUI() {
        title = "实训申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let url = SX_ApplyTraininigDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"
        /*
         状态字段status
         0:申请成功;1:就业顾问联系;2:支付成功;3:申请退款;4:审核通过;
         5:审核驳回;6:退款完成;7:取消申请
         */
        SX_NetManager.requestData(type: .GET, URlString: url, parameters:  nil, finishCallBack: { (result) in
            do{
                let json                 = try JSON(data: result)
                self.trainingApplyDetail = JSON(arrayLiteral: json["data"].dictionary ?? [:])
                self.applyStatus         = json["data"]["status"].string ?? ""
            } catch{ }
            self.table.reloadData()
            self.hideLoadingView()
        })
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_TrainingApplyDetailController: UITableViewDelegate, UITableViewDataSource {
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
            if self.applyStatus == "4" || self.applyStatus == "5" || self.applyStatus == "6" || self.applyStatus == "7" {
                return 3
            }else{
                return 4
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.trainingApplyDetail[indexPath.row]
        if indexPath.section == 0 {
            let cell = SX_ApplyProgressCell(style: .default, reuseIdentifier: "applyProgressCellID")
            cell.selectionStyle = .none
            
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
        }else if indexPath.section == 1 {
            let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: "applytrainingprohectCellID")
            cell.selectionStyle                     = .none
            
            cell.lineView?.isHidden                 = true
            cell.projectStyle?.isHidden             = true
            cell.projectPayAndRefund?.isHidden      = true
            cell.projectCancel?.isHidden            = true
            
            cell.projectTitle?.text                 = model["title"].string ?? "美国金融业务(测试)"
            cell.projectTime?.text                  = model["travel"].string ?? "5天(测试)"
            cell.projectAddress?.text               = model["address"].string ?? "美国/纽约(测试)"
            cell.projectDate?.text                  = model["departuretime"].string ?? "2018.10.10(测试)"
            
            return cell
        }
        
        let cell = SX_ApplyDetailMessageCell(style: .default, reuseIdentifier: "ApplyDetailMessageCellID")
        cell.backgroundColor          = UIColor.white
        cell.selectionStyle           = .none
        let messModel                 = self.trainingApplyDetail[0]
        switch indexPath.row {
        case 1:
            cell.title?.text          = "总金额"
            cell.title?.font          = UIFont.systemFont(ofSize: 14)
            cell.title?.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            cell.price?.text          = "¥" + (messModel["price"].string ?? "11.11(测试服务费)")
            cell.price?.font          = UIFont.systemFont(ofSize: 14)
            cell.price?.textColor     = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            break
        case 2:
            cell.title?.text          = "状态"
            cell.title?.font          = UIFont.systemFont(ofSize: 14)
            cell.title?.textColor     = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            cell.price?.text          = messModel["statusCn"].string ?? "未支付(测试)"
            cell.price?.font          = UIFont.systemFont(ofSize: 14)
            cell.price?.textColor     = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            break
        case 3:
            self.refundBtn = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(25.FloatValue.IPAD_XValue)
                make.width.equalTo(60.FloatValue.IPAD_XValue)
            }).config({ (REFUND) in
                REFUND.setTitle((messModel["buttonCn"].string ?? ""), for: .normal)
                REFUND.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
                REFUND.setTitleColor(UIColor.white, for: .normal)
                REFUND.backgroundColor = UIColor.SX_MainColor()
                if self.applyStatus == "2" || self.applyStatus == "3" {
                    REFUND.isHidden = false
                    
                }else{
                    REFUND.isHidden = true
                }
                
                REFUND.rx.tap.subscribe(onNext: { (_) in
                    
                    SXLog("点击申请退款!")
                    
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            if self.applyStatus == "2" || self.applyStatus == "3" { // 对应图3,4
                cell.title?.text      = "操作"
                cell.title?.font      = UIFont.boldSystemFont(ofSize: 14)
                cell.title?.textColor = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                
                cell.price?.isHidden  = true
                
            }else{
                cell.title?.text      = "应付金额"
                cell.title?.font      = UIFont.systemFont(ofSize: 14)
                cell.title?.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                cell.price?.text      = "¥" + (messModel["price"].string ?? "11.11(测试服务费)")
                cell.price?.font      = UIFont.boldSystemFont(ofSize: 16)
                cell.price?.textColor = UIColor.colorWithHexString(hex: "fc1614", alpha: 1)
            }
            
            break
        default: // 0
            cell.title?.text          = model["title"].string ?? "美国金融实习岗位-信托和过桥基金业务(测试)"
            cell.title?.font          = UIFont.boldSystemFont(ofSize: 16)
            cell.title?.textColor     = UIColor.colorWithHexString(hex: "333333", alpha: 1)
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.trainingApplyDetail[indexPath.section]
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
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
                PAY.setTitle("去支付", for: .normal)
                PAY.setTitleColor(UIColor.white, for: .normal)
                if self.applyStatus == "1" { //对应图2
                    PAY.isHidden = false
                }else{
                    PAY.isHidden = true
                }
                
                PAY.rx.tap.subscribe(onNext: { (_) in
                    SXLog("去支付 +++ + ")
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
                    CANCEL.isHidden = false //对应图2
                }else{
                    CANCEL.isHidden = true
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            SXLog("进入申请进度详情界面")
            let vc = SX_ApplyProgressDetailController()
            vc.typeStr = "training"
            vc.number  = self.number
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
