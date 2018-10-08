//
//  SX_MineEmploymentJobsController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 就业岗位

/*
 你用半生温柔相濡以沫陪我赌
 我又怎么可能让你输
 */

import UIKit
import SwiftyJSON

let employCellID = "employCellID"

class SX_MineEmploymentJobsController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 6)
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-40.FloatValue-kNavH)), style: .grouped)
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

// =============================================================
// MARK: - Other Method
// =============================================================
extension SX_MineEmploymentJobsController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
//        if <#condition#> {
//            <#code#>
//        }
        
//        SX_NetManager.requestData(type: .GET, URlString: SX_VIPCenter_MyCollection) { (result) in
//            do {
//
//            }catch { }
//        }
        
    }
}

// =================================================================
// MARK: - UITableViewDelegate
// =================================================================
extension SX_MineEmploymentJobsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: employCellID)
        cell.backgroundColor           = UIColor.white
        cell.selectionStyle            = .none
        cell.employmentTitle?.text     = "美国金融实习岗位-信托和过桥基金业务"
        cell.employmentDate?.text      = "2018.03.03"
        cell.employmentAddress?.text   = "美国/纽约"
        cell.employmentNature?.text    = "正式"
        
        switch indexPath.section {
        case 0: // 申请成功, 查看详情
            cell.employmentPay?.isHidden     = true
            cell.employmentNotiBtn?.isHidden = true
            
            cell.employmentStyle?.text = "申请成功"
            
            cell.employmentDetail?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentDetail?.titleLabel?.textAlignment = .center
            cell.employmentDetail?.setTitle("查看详情", for: .normal)
            cell.employmentDetail?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.employmentDetail?.rx.tap.subscribe(onNext: { (_) in
                SXLog("查看详情 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 1: //支付定金, 取消申请
            cell.employmentDetail?.isHidden  = true
            cell.employmentDetail?.isHidden  = true
            
            cell.employmentStyle?.text = "等待面试通知"
            
            cell.employmentNotiBtn?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentNotiBtn?.titleLabel?.textAlignment = .center
            cell.employmentNotiBtn?.setTitle("取消申请", for: .normal)
            cell.employmentNotiBtn?.setlineColor(color: UIColor.colorWithHexString(hex: "666666", alpha: 1))
            cell.employmentNotiBtn?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.employmentNotiBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("取消申请 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            /// 支付定金
            cell.employmentPay?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentPay?.titleLabel?.textAlignment = .center
            cell.employmentPay?.backgroundColor = UIColor.SX_MainColor()
            cell.employmentPay?.setTitle("支付定金", for: .normal)
            cell.employmentPay?.setTitleColor(UIColor.white, for: .normal)
            
            cell.employmentPay?.rx.tap.subscribe(onNext: { (_) in
                SXLog("支付定金 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 2: // 面试通知
            cell.employmentDetail?.isHidden  = true
            cell.employmentPay?.isHidden     = true
            cell.employmentPay?.isHidden     = true
            
            
            cell.employmentNotiBtn?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
            cell.employmentNotiBtn?.titleLabel?.textAlignment = .center
            cell.employmentNotiBtn?.setTitle("面试通知", for: .normal)
            cell.employmentNotiBtn?.setlineColor(color: UIColor.colorWithHexString(hex: "72a21b", alpha: 1))
            cell.employmentNotiBtn?.setTitleColor(UIColor.colorWithHexString(hex: "72a21b", alpha: 1), for: .normal)
            
            cell.employmentNotiBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("面试通知 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 3: // 等待面试反馈
            cell.employmentDetail?.isHidden  = true
            cell.employmentPay?.isHidden     = true
            cell.employmentNotiBtn?.isHidden = true
            cell.employmentPay?.isHidden     = true
            
            cell.employmentStyle?.text = "等待面试通知"
            
            break
        case 4: // 录用通知
            cell.employmentDetail?.isHidden  = true
            cell.employmentPay?.isHidden     = true
            cell.employmentPay?.isHidden     = true
            
            cell.employmentNotiBtn?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
            cell.employmentNotiBtn?.titleLabel?.textAlignment = .center
            cell.employmentNotiBtn?.setTitle("录用通知", for: .normal)
            cell.employmentNotiBtn?.setlineColor(color: UIColor.SX_MainColor())
            cell.employmentNotiBtn?.setTitleColor(UIColor.SX_MainColor(), for: .normal)
            
            cell.employmentNotiBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("录用通知 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case 5: // 退款
            cell.employmentPay?.isHidden     = true
            cell.employmentNotiBtn?.isHidden = true
            cell.employmentPay?.isHidden     = true
            
            cell.employmentStyle?.text = "应聘失败"
            
            cell.employmentDetail?.setTitle("退款", for: .normal)
            cell.employmentDetail?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentDetail?.setTitleColor(UIColor.white, for: .normal)
            cell.employmentDetail?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
            cell.employmentDetail?.rx.tap.subscribe(onNext: { (_) in
                SXLog("退款 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        default: break
            
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
        SXLog("进入就业岗位的申请详情")
        let vc = SX_ApplyDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

