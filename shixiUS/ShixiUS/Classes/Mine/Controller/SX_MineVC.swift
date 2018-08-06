//
//  SX_MineVC.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的

import UIKit

let minwCellID = "mineCellID"

class SX_MineVC: UIViewController {
    
    lazy var table: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.contentInset = UIEdgeInsetsMake(CGFloat(IMAGE_HEIGHT-kNavH), 0, 0, 0)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(table)
    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_MineVC {
    
    func setUI() {
        
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.title = "我的"
        
        
    }
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MineVC {
    
    
    
    
    
    
}

// ===============================================================================================================================
// MARK: -  UITableViewDelegate
// ===============================================================================================================================
extension SX_MineVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 3 {
            return 1
        }
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: minwCellID)
        
        cell.textLabel?.text = "MineCell的\(indexPath.section) ---- \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.FloatValue.IPAD_XValue
    }
}
