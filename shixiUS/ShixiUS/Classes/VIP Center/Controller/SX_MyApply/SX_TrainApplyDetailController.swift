//
//  SX_TrainApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/30.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情 --> (培训认证)

/*
 我们工作时间做的事,决定我们拥有什么
 我们工作闲暇做的事,决定我们成为哪种人
            乔治 伊士曼
 */

import UIKit

class SX_TrainApplyDetailController: SX_BaseController {
    
    
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
extension SX_TrainApplyDetailController {
    
    func setUI() {
        
        
        
    }
    
    func fetchData() {
        
        hideLoadingView()
        
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_TrainApplyDetailController: UITableViewDelegate, UITableViewDataSource {
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
extension SX_TrainApplyDetailController {
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainApplyDetailController {
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainApplyDetailController {
    
    
    
}

// ===============================================================================
// MARK: -
// ===============================================================================
extension SX_TrainApplyDetailController {

    
}
