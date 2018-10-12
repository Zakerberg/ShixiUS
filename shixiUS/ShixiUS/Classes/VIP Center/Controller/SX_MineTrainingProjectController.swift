//
//  SX_MineTrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 实训项目

/*
 别为了不属于你的观众
 演绎你不擅长的人生
 反正谢幕后的每次相逢
 都有我捧着鲜花
 把你拥入怀中
 */

import UIKit
import SwiftyJSON

let TRAININGCELLID = "tainingCellID"

class SX_MineTrainingProjectController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 4)
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-80.FloatValue-kNavH)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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

// ============================================================================================
// MARK: - Other Method
// ============================================================================================
extension SX_MineTrainingProjectController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
    }
}

// ============================================================================================
// MARK: - UITableViewDelegate
// ============================================================================================
extension SX_MineTrainingProjectController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: TRAININGCELLID)
        cell.selectionStyle         = .none
        cell.projectTitle?.text     = "华尔街投行实地项目"
        cell.projectAddress?.text   = "Los Angles"
        cell.projectDate?.text      = "2018.03.03"
        cell.projectTime?.text      = "5Day"
        
        switch indexPath.section {
        case 0:
            cell.projectCancel?.isHidden       = true
            cell.projectPayAndRefund?.isHidden = true
            
            cell.projectStyle?.text            = "申请成功"
            cell.projectContact?.text          = "等待客服联系"
            
            break
        case 1:
            cell.projectContact?.isHidden      = true
            cell.projectPayAndRefund?.isHidden = true
            
            cell.projectCancel?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.projectCancel?.titleLabel?.textAlignment = .center
            cell.projectCancel?.setTitle("取消申请", for: .normal)
            cell.projectCancel?.setlineColor(color: UIColor.colorWithHexString(hex: "666666", alpha: 1))
            cell.projectCancel?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.projectCancel?.rx.tap.subscribe(onNext: { (_) in
                SXLog("取消申请 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 2:
            cell.projectContact?.isHidden = true
            cell.projectCancel?.isHidden  = true
            
            
            cell.projectPayAndRefund?.setTitle("去支付", for: .normal)
            cell.projectPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.projectPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.projectPayAndRefund?.backgroundColor   = UIColor.SX_MainColor()
            cell.projectPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
                SXLog("去支付 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 3:
            cell.projectContact?.isHidden = true
            cell.projectCancel?.isHidden  = true
            
            
            cell.projectPayAndRefund?.setTitle("退款", for: .normal)
            cell.projectPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.projectPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.projectPayAndRefund?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
            cell.projectPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
                SXLog("退款 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.FloatValue.IPAD_XValue
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SXLog("进入实训项目的申请详情")
        let vc = SX_ApplyDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
