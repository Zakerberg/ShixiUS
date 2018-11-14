//
//  SX_ApplyProgressDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请进度详情

/*
 海有舟可渡,
 山有路可行.
 此爱隔山海,
 山海亦可平.
 */

import UIKit

let progressDetailCellID = "progressDetailCellID"

class SX_ApplyProgressDetailController: SX_BaseController {
    
    var dataArr = ["q", "q", "q"]
    
    lazy var progressTab: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
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
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_ApplyProgressDetailController {
    
    func setUI() {
        title = "进度详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(progressTab)
    }
    
    func fetchData() {
       
        
        
        
        
        
        
        
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyProgressDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_ProgressDetailCell(style: .default, reuseIdentifier: progressDetailCellID)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UILabel.SX_getSpaceLabelHeight("self.progressDesArr[indexPath.row] as NSString", font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 50.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}
