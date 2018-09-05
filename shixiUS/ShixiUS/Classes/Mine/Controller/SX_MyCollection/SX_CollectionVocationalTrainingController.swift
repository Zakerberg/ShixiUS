//
//  SX_CollectionVocationalTrainingController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的收藏 --> 职业培训

/*
 我爱你
 若以朋友的身份可以一直在你身边
 陪你笑
 陪你疯
 陪你哭
 这样一辈子
 就挺好
 */

import UIKit

let collectionVocationCellID = "collectionVocationCellID"

class SX_CollectionVocationalTrainingController: UIViewController {
    
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===================================================================================================================
// MARK: - Other Method
// ===================================================================================================================
extension SX_CollectionVocationalTrainingController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    
}

// ===================================================================================================================
// MARK: - UITableViewDelegate
// ===================================================================================================================
extension SX_CollectionVocationalTrainingController:UITableViewDelegate, UITableViewDataSource {
    
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
        
        cell.vocationalContact?.isHidden = true
        cell.vocationalCancel?.isHidden  = true
        
        
        cell.vocationalPayAndRefund?.setTitle("立即申请", for: .normal)
        cell.vocationalPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
        cell.vocationalPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
        cell.vocationalPayAndRefund?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
        cell.vocationalPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
            SXLog("立即申请 ++++")
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
}
