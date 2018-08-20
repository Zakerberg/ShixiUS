//
//  SX_OrderDetailsController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/20/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  订单详情界面

import UIKit

class SX_OrderDetailsController: UIViewController {
    
    lazy var OrderdetailTable: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.delegate   = self
        tableView.dataSource = self
        
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

// ===========================================================================================================================
// MARK: - Other Method
// ===========================================================================================================================
extension SX_OrderDetailsController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.OrderdetailTable)
    }
    
    func fetchData() {
        
    }
}

// ===========================================================================================================================
// MARK: - UITableViewDelegate
// ===========================================================================================================================
extension SX_OrderDetailsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = SX_OrderPayInfoCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.tradingStauts?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.tradingStauts?.text = "已付款"
            cell.payTime?.text   = "付款时间: "  + "2018-01-12 16:32:10"
            cell.orderNum?.text  = "订 单 号 : "  + "89558565412"
            cell.makeOrder?.text = "下单时间: "  + "2018-01-12 16:32:10"
            cell.payPrice?.text  = "订单金额: "  + "1.00"
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = SX_OrderPayInfoCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.tradingStauts?.font = UIFont.boldSystemFont(ofSize: 15)
            cell.tradingStauts?.text = "支付信息"
            cell.payTime?.text   = "支付时间: "  + "2018-01-12 16:32:10"
            cell.orderNum?.text  = "交 易 号 : "  + "89558565412"
            cell.makeOrder?.text = "支付方式: "  + "支付宝"
            cell.payPrice?.text  = "支付金额: "  + "1.00"
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.text = "我是\(indexPath.section)"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            return 234.FloatValue.IPAD_XValue
        } else {
            return 130.FloatValue.IPAD_XValue
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Margin
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
