//
//  SX_TrainApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/30.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情 --> (培训认证)

/*
 我们工作时间做的事,决定我们拥有什么
 我们工作闲暇做的事,决定我们成为哪种人
 乔治 伊士曼
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_TrainApplyDetailController: SX_BaseController {
    
    var number:String?
    var applyStatus:String?
    var trainApplyDetail = JSON()
    
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
extension SX_TrainApplyDetailController {
    
    func setUI() {
        title = "职业培训申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let url = SX_ApplyTrainDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"
        /*
         状态字段status
         0:申请成功;1:就业顾问联系;2:支付成功;3:申请退款;4:审核通过
         5:审核驳回;6:退款完成;7:取消申请
         */
        SX_NetManager.requestData(type: .GET, URlString: url, parameters:  nil, finishCallBack: { (result) in
            do{
                let json              = try JSON(data: result)
                self.trainApplyDetail = JSON(arrayLiteral: json["data"].dictionary ?? [:])
                self.applyStatus      = json["data"]["status"].string ?? ""
            } catch{ }
            self.table.reloadData()
            self.hideLoadingView()
        })
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_TrainApplyDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = SX_ApplyProgressCell(style: .default, reuseIdentifier: "applyProgressCellID")
            cell.selectionStyle = .none
            if self.applyStatus == "7" { // 订单已经取消
                cell.progressNormalBgView?.isHidden = true
                cell.progressBgView?.isHidden       = false
                cell.progressBtn?.isHidden          = true
                cell.progressRejected?.text         =  "测试订单取消" //model["steps"].string ??
            }else {
                cell.accessoryType                  = .disclosureIndicator
                cell.progressNormalBgView?.isHidden = false
                cell.progressBgView?.isHidden       = true
                cell.progressStep?.text             =  "测试进度标题" //model["steps"].string ??
                cell.progressStatus?.text           =  "测试申请进度测试"//model["stepsCn"].string ??
            }
            
            return cell
        }else if indexPath.section == 1 {
            let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: "applytrainingprohectCellID")
            cell.selectionStyle                     = .none
            cell.projectTitle?.text                 = "1111"
            cell.projectTime?.text                  = "2018.10.10"
            cell.projectDate?.text                  = "5天"
            
            cell.lineView?.isHidden                 = true
            cell.projectStyle?.isHidden             = true
            cell.projectPayAndRefund?.isHidden      = true
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "trainApplyDetailCellID")
        
        
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if self.applyStatus == "7" { // 订单已经取消
                return 100.FloatValue.IPAD_XValue
            }else{
                return UILabel.SX_getSpaceLabelHeight("测试申请进度测试/测试申请进度测试/测试申请进度测试/测试申请进度测试?测试申请进度测试", font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 40.FloatValue.IPAD_XValue
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            SXLog("进入申请进度详情界面")
            let vc = SX_ApplyProgressDetailController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainApplyDetailController {
    
}



