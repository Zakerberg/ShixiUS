//
//  SX_MinePersonalController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息

import UIKit

class SX_MinePersonalController: UIViewController {

    var titleArr   = ["头像", "用户名", "手机号", "国家/地区", "微信", "邮箱"]
    var contentArr = ["", "请输入姓名", "请输入手机号", "请选择国家和地区", "请输入微信", "请输入邮箱"]

    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "个人信息"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.table)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MinePersonalController {
    

    
    
    

}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
extension SX_MinePersonalController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     
        if indexPath.row == 0 {
            return 100.FloatValue.IPAD_XValue
        }
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let iconCell = SX_PersonalIconCell(style: .default, reuseIdentifier: nil)
            iconCell.selectionStyle = .none
            
            
            return iconCell
        }
        
        let cell = SX_PersonalMessageCell(style: .default, reuseIdentifier: nil)
        
        cell.titleLabel?.text = self.titleArr[indexPath.row]
        cell.tF?.placeholder  = self.contentArr[indexPath.row]
        
        cell.selectionStyle = .none
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ===============================================================================================================================
// MARK: - UITextFieldDelegate
// ===============================================================================================================================
extension SX_MinePersonalController: UITextFieldDelegate {
    
 
    
    
    
    
    
    
}
