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

class SX_ApplyProgressDetailController: UIViewController {

    var dataArr = [Int](repeating: 8, count: 5)
    
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

// ======================================================================================================================
// MARK: - Other Method
// ======================================================================================================================
extension SX_ApplyProgressDetailController {
    
    func setUI() {
        title = "进度详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        
    }

    func fetchData() {
        
    }
}

// ======================================================================================================================
// MARK: - UITableViewDelegate
// ======================================================================================================================
extension SX_ApplyProgressDetailController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: progressDetailCellID)
        
        
        
        
        
        
        
        return cell
    }
}

// ======================================================================================================================
// MARK: -
// ======================================================================================================================
extension SX_ApplyProgressDetailController {
    
    
    
}

// ======================================================================================================================
// MARK: -
// ======================================================================================================================
extension SX_ApplyProgressDetailController {
    
    
    
}




