//
//  SX_ApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情界面

import UIKit

let applyDetailCellID = "applyDetailCellID"
class SX_ApplyDetailController: UIViewController {
    
    var payBtn    : UIButton?
    var cancelBtn : UIButton?
    
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
        setUI()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ======================================================================================================================
// MARK: - Other Method
// =======================================================================================================================
extension SX_ApplyDetailController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
    }
    
    func fetchData() {
        
        
    }
}

// ========================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================
extension SX_ApplyDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = SX_ApplyProgressCell(style: .default, reuseIdentifier: nil)
            cell.backgroundView?.isHidden = true
            cell.accessoryType            = .disclosureIndicator
            cell.selectionStyle           = .none
            cell.progressBgView?.isHidden = true
            cell.progressStatus?.text     = "等待客服联系这是测试的数据为了显示换行,确实要换行啊,还要多少字?换行了吧!"
            cell.progressTime?.text       = "2018-07-10 20:55:00"
            
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: applyDetailCellID)
        cell.backgroundColor = UIColor.yellow
        cell.textLabel?.text = "我是\(indexPath.section)----\(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return UILabel.SX_getSpaceLabelHeight("等待客服联系这是测试的数据为了显示换行,确实要换行啊,还要多少字?换行了吧!", font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 80
        }
        
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            SXLog("进入申请进度详情界面")
            
        } else {
         
            
        }
    }
}

// ========================================================================================================================
// MARK: -
// ========================================================================================================================
extension SX_ApplyDetailController {
    
    
    
    
    
    
    
}
