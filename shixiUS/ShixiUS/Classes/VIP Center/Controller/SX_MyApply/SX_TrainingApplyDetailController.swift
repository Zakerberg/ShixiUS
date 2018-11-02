//
//  SX_TrainingApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/30.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情 --> (实训项目)

/*
 在没有你的世界里
 任何愿望都无法实现
 宇多田光 -- <<镰仓物语>> 电影主题曲
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_TrainingApplyDetailController: SX_BaseController {
    
    var number: String?
    
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate        = self
        tableView.dataSource      = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================
// MARK: - Other Method
// ===============================================================================
extension SX_TrainingApplyDetailController{
   
    func setUI() {
        title = "就业申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
        let url = SX_ApplyTraininigDetail + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number!)"

        
        
        
        
        
        hideLoadingView()
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_TrainingApplyDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
     let cell = UITableViewCell(style: .default, reuseIdentifier: "trainApplyDetailCellID")
        
        return cell
    }
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController {
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainingApplyDetailController{
    
    
}
