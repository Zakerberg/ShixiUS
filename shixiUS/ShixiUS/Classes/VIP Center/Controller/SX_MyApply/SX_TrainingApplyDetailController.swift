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
    var statusBtn: UIButton? // 状态(申请退款)
    
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
        title = "就业申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
        let url = SX_ApplyTraininigDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"
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
                cell.progressStatus?.text           = model["stepsCn"].string ?? "测试申请进度测试"
            }


            
            
            return cell
        }else if indexPath.section == 1 {
            let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: "applytrainingprohectCellID")
            cell.selectionStyle = .none
            
            
//            var projectTitle        : UILabel?
//            var projectAddress      : UILabel?
//            var projectTime         : UILabel?
//            var projectDate         : UILabel?
//            var projectStyle        : UILabel?


            cell.projectTitle?.text = "1111"
            cell.projectTime?.text  = "2018.10.10"
            cell.projectDate?.text  = "5天"
            
            cell.lineView?.isHidden = true
            cell.projectStyle?.isHidden = true
            cell.projectPayAndRefund?.isHidden = true
            
            
            
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "trainApplyDetailCellID")
        
        return cell
    }
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController {
    
    
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
    
    
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
}
