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

let collectionEmpCellID = "collectionEmpCellID"

class SX_CollextionEmploymentJobsController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 6)
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===================================================================================================================
// MARK: - Other Method
// ===================================================================================================================
extension SX_CollextionEmploymentJobsController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    
}

// ===================================================================================================================
// MARK: - UITableViewDelegate
// ===================================================================================================================
extension SX_CollextionEmploymentJobsController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: collectionEmpCellID)
        cell.backgroundColor           = UIColor.white
        cell.selectionStyle            = .none
        cell.employmentTitle?.text     = "美国金融实习岗位-信托和过桥基金业务"
        cell.employmentDate?.text      = "2018.03.03"
        cell.employmentAddress?.text   = "美国/纽约"
        cell.employmentNature?.text    = "正式"
        
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
