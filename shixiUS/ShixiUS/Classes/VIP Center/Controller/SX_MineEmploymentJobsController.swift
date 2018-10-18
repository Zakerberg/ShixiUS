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
import MBProgressHUD

let employCellID = "employCellID"

class SX_MineEmploymentJobsController: UIViewController {
    
    var noDataView: SX_NoDataView?
    var jobApplyArr = [SX_JobApplyModel]()
    
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
        Noti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
        
        self.noDataView = SX_NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-40.FloatValue-kNavH)).addhere(toSuperView: table)
        self.noDataView?.isHidden = true
    }
    
    func fetchData() {
       // if String(describing: USERDEFAULTS.value(forKey: "login")!) == "yes"{
            let url = SX_MyApplyJob + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))"
            
            SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
                do {
                    let json = try JSON(data: result)
                    if json["status"].int == 200 {
                        SXLog("成功!")
                        for item in json["data"].array ?? [] {
                            let jobApplyModel = SX_JobApplyModel(jsonData: item)
                            self.jobApplyArr.append(jobApplyModel)
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
                    self.table.reloadData()
                }catch { }
            }
//        }else{
//            let vc  = SX_LoginController()
//            self.present(vc, animated: true, completion: nil)
//        }
    }
}

// =================================================================
// MARK: - UITableViewDelegate
// =================================================================
extension SX_MineEmploymentJobsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.jobApplyArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: employCellID)
        cell.backgroundColor           = UIColor.white
        cell.selectionStyle            = .none
        let model                      = jobApplyArr[indexPath.section]
        cell.employmentTitle?.text     = model.title ?? "美国金融实习岗位-信托和过桥基金业务"
        cell.employmentDate?.text      = model.time ?? "2018.03.03"
        cell.employmentAddress?.text   = model.address ?? "美国/纽约"
        cell.employmentNature?.text    = model.nature ?? "正式"
        
        switch model.status {
        case "1"?: //支付定金, 取消申请
            cell.employmentDetail?.isHidden  = true
            cell.employmentDetail?.isHidden  = true
            
            cell.employmentStyle?.text       = model.statusCn
            
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
            cell.employmentPay?.setTitle(model.button, for: .normal)
            cell.employmentPay?.setTitleColor(UIColor.white, for: .normal)
            
            cell.employmentPay?.rx.tap.subscribe(onNext: { (_) in
                SXLog("支付定金 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            break
        case "4"?: // 退款
            cell.employmentPay?.isHidden     = true
            cell.employmentNotiBtn?.isHidden = true
            cell.employmentPay?.isHidden     = true
            
            cell.employmentStyle?.text       = model.statusCn
            
            cell.employmentDetail?.setTitle(model.button, for: .normal)
            cell.employmentDetail?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentDetail?.setTitleColor(UIColor.white, for: .normal)
            cell.employmentDetail?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
            cell.employmentDetail?.rx.tap.subscribe(onNext: { (_) in
                SXLog("退款 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        case "6"?: // 支付尾款
            cell.employmentPay?.isHidden     = true
            cell.employmentNotiBtn?.isHidden = true
            cell.employmentPay?.isHidden     = true

            cell.employmentStyle?.text       = model.statusCn
            
            cell.employmentDetail?.setTitle(model.button, for: .normal)
            cell.employmentDetail?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.employmentDetail?.setTitleColor(UIColor.white, for: .normal)
            cell.employmentDetail?.backgroundColor   = UIColor.SX_MainColor()
            cell.employmentDetail?.rx.tap.subscribe(onNext: { (_) in
                SXLog("支付尾款 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
        default:
            cell.employmentDetail?.isHidden  = true
            cell.employmentPay?.isHidden     = true
            cell.employmentPay?.isHidden     = true
            
            cell.employmentStyle?.text       = model.statusCn
            
            cell.employmentNotiBtn?.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 14)
            cell.employmentNotiBtn?.titleLabel?.textAlignment = .center
            cell.employmentNotiBtn?.setTitle(model.button, for: .normal)
            cell.employmentNotiBtn?.setlineColor(color: UIColor.colorWithHexString(hex: "72a21b", alpha: 1))
            cell.employmentNotiBtn?.setTitleColor(UIColor.colorWithHexString(hex: "72a21b", alpha: 1), for: .normal)
            
            cell.employmentNotiBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("面试通知 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
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
        SXLog("进入就业岗位的申请详情")
        let vc = SX_ApplyDetailController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// ======================================================================
// MARK: - RxSwift 通知处理
// ======================================================================
extension SX_MineEmploymentJobsController {
    func Noti() {
        NotificationCenter.default.rx.notification(NSNotification.Name(rawValue: "LOGINSUCCESS")).takeUntil(self.rx.deallocated).subscribe(onNext: { (noti) in
            self.fetchData()
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
    }
}
