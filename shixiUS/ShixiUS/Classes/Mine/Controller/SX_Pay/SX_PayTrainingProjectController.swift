//
//  SX_PayTrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/8/29.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  付款记录 --> 实训项目

/*
 我爱你
 所以我把我整个灵魂都给了你
 连同他的怪癖，耍小脾气忽明忽暗
 一千八百种坏毛病 它真讨厌
 只有一点真好
 爱你
 */

import UIKit
import MBProgressHUD
import SwiftyJSON

class SX_PayTrainingProjectController: UIViewController {
    
    var noDataView: SX_NoDataView?
    var jobOrderArr = [SX_MyOrdelRecordModel]()
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-40.FloatValue-kNavH)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
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

// =====================================================================
// MARK: - Other Method
// =====================================================================
extension SX_PayTrainingProjectController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
        self.noDataView = SX_NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-40.FloatValue-kNavH)).addhere(toSuperView: table)
        self.noDataView?.isHidden = true
    }
    
    func fetchData() {
        let url = SX_Mine_OrderRecord + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&iscate=2"
        
        SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
            do {
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    SXLog("成功!")
                    for item in json["data"].array ?? [] {
                        let orderModel = SX_MyOrdelRecordModel(jsonData: item)
                        self.jobOrderArr.append(orderModel)
                    }
                    self.table.reloadData()
                    if json["data"].count == 0 {
                        self.noDataView?.isHidden = false
                    }else{
                        self.noDataView?.isHidden = true
                    }
                }else{
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

// =====================================================================
// MARK: - UITableViewDelegate
// =====================================================================
extension SX_PayTrainingProjectController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.jobOrderArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_PaymentCell(style: .default, reuseIdentifier: paymentCellID)
        cell.selectionStyle  = .none
        
        let model            = jobOrderArr[indexPath.section]
        cell.payTitle?.text  = model.title ?? "美国金融实习岗位 - 信托和过桥基金业务"
        cell.payDate?.text   = model.time ?? "2018.03.03"
        cell.payMoney?.text  = model.price ?? "$600.00"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
}
