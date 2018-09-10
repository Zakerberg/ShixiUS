//
//  SX_HotJobDetailController.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位详情

/*
 我无法确定你是否把我推开
 我可以确定的是
 无论你把我推开多少次
 我都会回来
 */

import UIKit

let hotJobDetailCellID = "hotJobDetailCellID"

class SX_HotJobDetailController: UIViewController {

    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
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


extension SX_HotJobDetailController {
   
    func setUI() {
        
        
    }
    
    func fetchData() {
        
    }
}

// =================================================================================================================
// MARK: -
// =================================================================================================================
extension SX_HotJobDetailController {

}


// =================================================================================================================
// MARK: -
// =================================================================================================================
extension SX_HotJobDetailController {

}


// =================================================================================================================
// MARK: -  UITableViewDelegate
// =================================================================================================================
extension SX_HotJobDetailController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = UITableViewCell(style: .default, reuseIdentifier: hotJobDetailCellID)
        
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

}










