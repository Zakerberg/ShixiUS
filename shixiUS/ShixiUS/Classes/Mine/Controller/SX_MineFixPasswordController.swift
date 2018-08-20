//
//  SX_MineFixPasswordController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  修改密码

import UIKit

class SX_MineFixPasswordController: UIViewController {
    
    var fixBtn   : UIButton?
    
    lazy var fixTable: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.delegate   = self
        tableView.dataSource = self
        
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

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_MineFixPasswordController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.fixTable)
        
    }
    
    func fetchData() {
        
    }
}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
extension SX_MineFixPasswordController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        let TF = UITextField().addhere(toSuperView: cell.contentView).layout { (make) in
            make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
            make.centerY.equalToSuperview()
            make.height.equalTo(45.FloatValue.IPAD_XValue)
            }.config { (TF) in
                TF.tintColor = UIColor.SX_MainColor()
                TF.textAlignment = .left
        }
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "原密码"
            TF.placeholder = "输入旧密码"
        } else if indexPath.section == 1 && indexPath.row == 0 {
            cell.textLabel?.text = "新密码"
            TF.placeholder = "新密码"
        }else{
            cell.textLabel?.text = "确认密码"
            TF.placeholder = "再次输入新密码"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        } else {
            let view = UIView()
            
            self.fixBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(45.FloatValue.IPAD_XValue)
            }).config({ (FIX) in
                FIX.backgroundColor = UIColor.SX_MainColor()
                FIX.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                FIX.setTitle("修改", for: .normal)
                FIX.layer.masksToBounds = true
                FIX.layer.cornerRadius = 10
                FIX.rx.tap.subscribe(onNext: { (_) in
                    SXLog("修改密码 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if  section == 0 {
            return CGFloat.leastNormalMagnitude
        }
        return 100.FloatValue.IPAD_XValue
    }
}


