//
//  SX_CollectionTrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的收藏 --> 项目实训

/*
 我爱你，
 你说你喜欢活在梦里
 像是清晨的山躲入蒙蒙雾气
 你在哪我都随你
 你爱晨山雾气
 我只爱身边有你
 */

import UIKit

let collectionTrainingCellID = "collectionTrainingCellID"

class SX_CollectionTrainingProjectController: UIViewController {
    
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

// ================================================================================
// MARK: - Other Method
// ================================================================================
extension SX_CollectionTrainingProjectController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
}

// ================================================================================
// MARK: - UITableViewDelegate
// ================================================================================
extension SX_CollectionTrainingProjectController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: collectionTrainingCellID)
        cell.selectionStyle         = .none
        cell.projectTitle?.text     = "华尔街投行实地项目"
        cell.projectAddress?.text   = "Los Angles"
        cell.projectDate?.text      = "2018.03.03"
        cell.projectTime?.text      = "5Day"
        
        cell.projectContact?.isHidden = true
        cell.projectCancel?.isHidden  = true
        
        cell.projectPayAndRefund?.setTitle("立即申请", for: .normal)
        cell.projectPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
        cell.projectPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
        cell.projectPayAndRefund?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
        cell.projectPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
            SXLog("立即申请 ++++")
            let vc = SX_ApplyTrainListController()
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
}

