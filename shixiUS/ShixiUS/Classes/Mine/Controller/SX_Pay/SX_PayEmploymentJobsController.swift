//
//  SX_PayEmploymentJobsController.swift
//  ShixiUS
//
//  Created by heather on 2018/8/29.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  付款记录 --> 就业岗位

import UIKit

let paymentCellID = "paymentCellID"

class SX_PayEmploymentJobsController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 8)
    
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
        fetchdata()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ======================================================================================================================
// MARK: - Other Method
// ======================================================================================================================
extension SX_PayEmploymentJobsController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchdata() {
        
    }
}

// ======================================================================================================================
// MARK: -
// ======================================================================================================================
extension SX_PayEmploymentJobsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_PaymentCell(style: .default, reuseIdentifier: paymentCellID)
        cell.selectionStyle  = .none
        cell.payTitle?.text  = "美国金融实习岗位 - 信托和过桥基金业务"
        cell.payDate?.text   = "2018.03.03"
        cell.payMoney?.text  = "$600.00"
        
        
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

// ======================================================================================================================
// MARK: -
// ======================================================================================================================
extension SX_PayEmploymentJobsController {
    
    
    
    
    
    
    
    
}






