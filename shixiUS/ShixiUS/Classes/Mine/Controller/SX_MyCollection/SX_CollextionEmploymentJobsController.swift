//
//  SX_CollextionEmploymentJobsController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的收藏 --> 就业岗位

/*
 我爱你
 愿以后我不在你身边
 会有更好的人代替
 他会给你备好胃药
 记得你不爱吃巧克力
 */

import UIKit
import MBProgressHUD
import SwiftyJSON

let collectionEmpCellID = "collectionEmpCellID"

class SX_CollextionEmploymentJobsController: UIViewController {
    
    var noDataView: SX_NoDataView?
    var collectionJobArr  = [JobCollectionListModel]()
    
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

// ===========================================================================
// MARK: - Other Method
// ===========================================================================
extension SX_CollextionEmploymentJobsController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
        self.noDataView = SX_NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-40.FloatValue-kNavH)).addhere(toSuperView: table)
        self.noDataView?.isHidden = true
    }
    
    func fetchData() {
        let url = SX_VIPCenter_MyCollection + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&type=1"
        
        SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
            do {
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    SXLog("获取就业岗位申请成功!")
                    for item in json["data"]["lists"].array ?? [] {
                        let collectionJobModel = JobCollectionListModel(jsonData: item)
                        self.collectionJobArr.append(collectionJobModel)
                    }
                    self.table.reloadData()
                    if json["data"]["lists"].count == 0 {
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

// ===========================================================================
// MARK: - UITableViewDelegate
// ===========================================================================
extension SX_CollextionEmploymentJobsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.collectionJobArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: collectionEmpCellID)
        cell.backgroundColor             = UIColor.white
        cell.selectionStyle              = .none
        
        let model                        = collectionJobArr[indexPath.row]
        cell.employmentTitle?.text       = model.title ?? "测试岗位信息"
        
        //cell.employmentDate?.text        =
        cell.employmentAddress?.text     = model.address ?? "美国/纽约"
        cell.employmentNature?.text      = model.duration_name ?? "全职(测试)"
        
        cell.employmentDetail?.isHidden  = true
        cell.employmentPay?.isHidden     = true
        cell.employmentPay?.isHidden     = true
        
        
        cell.employmentNotiBtn?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
        cell.employmentNotiBtn?.titleLabel?.textAlignment = .center
        cell.employmentNotiBtn?.setTitle("立即申请", for: .normal)
        cell.employmentNotiBtn?.setlineColor(color: UIColor.colorWithHexString(hex: "72a21b", alpha: 1))
        cell.employmentNotiBtn?.setTitleColor(UIColor.colorWithHexString(hex: "72a21b", alpha: 1), for: .normal)
        
        cell.employmentNotiBtn?.rx.tap.subscribe(onNext: { (_) in
            SXLog("立即申请 ++++")
            let vc = SX_ApplyEmpListController()
            self.navigationController?.pushViewController(vc, animated: true)
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
        
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
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
