//
//  SX_MineVocationalTrainingController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请,我的收藏,付款记录 ---> 职业培训

/*
 我爱你
 又很遗憾没有人能证明
 可这份爱已经如鲸向海
 如鸟投林
 无可避免
 退无可退了
 */

import UIKit

let vocationalCellID = "vocationalCellID"

class SX_MineVocationalTrainingController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 4)
    
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

// =======================================================================================================================
// MARK: - Other Method
// =======================================================================================================================
extension SX_MineVocationalTrainingController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
    }
}

// =======================================================================================================================
// MARK: -
// =======================================================================================================================
extension SX_MineVocationalTrainingController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_VocationalTrainingCell(style: .default, reuseIdentifier: vocationalCellID)
        cell.selectionStyle            = .none
        cell.vocationalTitle?.text     = "算法工程师培训"
        cell.vocationalPeriod?.text    = "第一期 | 2018-02-16"
        cell.vocationalDate?.text      = "2018.03.03"
        
        
        switch indexPath.section {
        case 0:
            cell.vocationalCancel?.isHidden       = true
            cell.vocationalPayAndRefund?.isHidden = true
            
            cell.vocationalStyle?.text            = "申请成功"
            cell.vocationalContact?.text          = "等待客服联系"
            
            break
        case 1:
            cell.vocationalContact?.isHidden      = true
            cell.vocationalPayAndRefund?.isHidden = true
            
            cell.vocationalCancel?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.vocationalCancel?.titleLabel?.textAlignment = .center
            cell.vocationalCancel?.setTitle("取消申请", for: .normal)
            cell.vocationalCancel?.setlineColor(color: UIColor.colorWithHexString(hex: "666666", alpha: 1))
            cell.vocationalCancel?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.vocationalCancel?.rx.tap.subscribe(onNext: { (_) in
                SXLog("取消申请 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 2:
            cell.vocationalContact?.isHidden = true
            cell.vocationalCancel?.isHidden  = true
            
            
            cell.vocationalPayAndRefund?.setTitle("去支付", for: .normal)
            cell.vocationalPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.vocationalPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.vocationalPayAndRefund?.backgroundColor  = UIColor.SX_MainColor()
            cell.vocationalPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
                SXLog("去支付 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 3:
            cell.vocationalContact?.isHidden = true
            cell.vocationalCancel?.isHidden  = true
            
            
            cell.vocationalPayAndRefund?.setTitle("退款", for: .normal)
            cell.vocationalPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.vocationalPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.vocationalPayAndRefund?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
            cell.vocationalPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
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
        SXLog("进入职业培训的申请详情")
        let vc = SX_ApplyDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

