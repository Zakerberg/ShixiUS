//
//  SX_ApplyTrainListController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/5.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目的申请表

/*
 因为一个人，才爱上一座城
 我从你城门走过
 守城的卫士告诉我，在等黎明
 */

import UIKit

class SX_ApplyTrainListController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 6)
    
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
extension SX_ApplyTrainListController {
    
    func setUI() {
        title = "实训项目申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
    }
    
    func fetchData() {
        
    }
    
    
    
}

// ===================================================================================================================
// MARK: - UITableViewDelegate
// ===================================================================================================================
extension SX_ApplyTrainListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
    
        return cell
    }
    
    
    
    
}

// ===================================================================================================================
// MARK: -
// ===================================================================================================================
extension SX_ApplyTrainListController {
    
    
    
}
