//
//  SX_ApplyEmpListController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/5.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  就业岗位的申请表

/*
 至死不渝的誓言最深情
 天荒地老的许诺最浪漫
 而我只想，陪你走过白发苍苍的平淡
 */

import UIKit

class SX_ApplyEmpListController: UIViewController {
    
    var applyBtn: UIButton?
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled              = false
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

// ===================================================================================================================
// MARK: - Other Method
// ===================================================================================================================
extension SX_ApplyEmpListController {
    
    func setUI() {
        title = "就业岗位申请"
        self.view.addSubview(table)
    }
}

// ===================================================================================================================
// MARK: - UITableViewDelegate
// ===================================================================================================================
extension SX_ApplyEmpListController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.textLabel?.text          = "上传简历、求职信"
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 15)
            } else if indexPath.row == 1 {
                cell.textLabel?.text = "上传简历"
            } else if indexPath.row == 2 {
                cell.textLabel?.text = "求职信"
            }
            
        }else{
            let TF = UITextField().addhere(toSuperView: cell.contentView).layout { (make) in
                make.left.equalToSuperview().offset(100.FloatValue.IPAD_XValue)
                make.centerY.equalToSuperview()
                make.height.equalTo(45.FloatValue.IPAD_XValue)
                }.config { (TF) in
                    TF.tintColor = UIColor.SX_MainColor()
                    TF.textAlignment = .left
            }
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "微信号:"
                TF.placeholder       = "请输入微信号"
            }
            cell.textLabel?.text = "手机号:"
            TF.placeholder       = "请输入手机号"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            return UIView()
        }else {
            let view = UIView()
            self.applyBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(45.FloatValue.IPAD_XValue)
            }).config({ (APPLY) in
                APPLY.backgroundColor = UIColor.SX_MainColor()
                APPLY.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                APPLY.setTitle("立即申请", for: .normal)
                APPLY.layer.masksToBounds = true
                APPLY.layer.cornerRadius = 10
                APPLY.rx.tap.subscribe(onNext: { (_) in
                    SXLog("岗位就业申请表的立即申请 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10.FloatValue.IPAD_XValue
        }
        return 100.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}
