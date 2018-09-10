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

let applyListIdentifier = "applyListIdentifier"
let applyAddressCellID  = "applyAddressCellID"

class SX_ApplyTrainListController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 16)
   
    lazy var table: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor  = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate         = self
        tableView.dataSource       = self
        
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
extension SX_ApplyTrainListController {
    
    func setUI() {
        title = "实训项目申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
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
        
        if indexPath.row == 0 { /// 标题: 全球公民学院
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            cell.textLabel?.text          = "全球公民学院"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font          = UIFont.boldSystemFont(ofSize: 16)
            cell.textLabel?.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            
            return cell
        }else if indexPath.row == 5 || indexPath.row == 6 { // 单选按钮cell (是否有签证)
            let cell = SX_ApplyVisaCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            if indexPath.row == 5 {
                cell.title?.text = "是否有美国签证"
                cell.trueBtn?.rx.tap.subscribe(onNext: { (_) in
                    SXLog("有美国签证")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
                
                cell.falseBtn?.rx.tap.subscribe(onNext: { (_) in
                    SXLog("没有美国签证")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            } else {
                cell.title?.text = "是否在校"
                cell.trueBtn?.rx.tap.subscribe(onNext: { (_) in
                    SXLog("在校")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
                
                cell.falseBtn?.rx.tap.subscribe(onNext: { (_) in
                    SXLog("不在校")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            }
            
            return cell
        } else if indexPath.row == 2 || indexPath.row == 12 { // 国家选择 & 地址选择
            let cell = SX_ApplyAddressCell(style: .default, reuseIdentifier: applyAddressCellID)
            cell.selectionStyle = .none
            
            if indexPath.row == 2 {
                cell.title?.text = "所在国家"
            } else {
                cell.title?.text = "地址"
            }
            
            cell.addressBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("地址选择")
                let addressPicker = SX_AddressViewController()
                addressPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
                // 返回选择数据,地址,省,市,区
                addressPicker.backLocationStringController = { (address,province,city,area) in
                    cell.addressBtn?.setTitle(address, for: .normal)
                }
                self.present(addressPicker, animated: true, completion: nil)
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            
            return cell
        } else if indexPath.row == 13 || indexPath.row == 14 { // 上传简历 & 求职信
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            cell.textLabel?.text = "上传简历"
            
            return cell
        } else {
            let cell = SX_ApplyMessageCell(style: .default, reuseIdentifier: applyListIdentifier)
            cell.selectionStyle = .none
            
            switch indexPath.row {
                
            case 1:
                cell.title?.text           = "姓名"
                cell.TF?.placeholder       = "输入您的姓名"
                
                break
            case 3:
                cell.title?.text           = "手机"
                cell.TF?.placeholder       = "输入您的手机号"
                cell.TF?.keyboardType      = .phonePad
                
                break
            case 4:
                cell.title?.text           = "邮箱"
                cell.TF?.placeholder       = "输入您的邮箱"
                
                break
            case 7:
                cell.title?.text           = "微信"
                cell.TF?.placeholder       = "输入您的微信"
                
                break
            case 8:
                cell.title?.text           = "年龄"
                cell.TF?.placeholder       = "输入您的年龄"
                
                break
            case 9:
                cell.title?.text           = "学校"
                cell.TF?.placeholder       = "输入您的学校"
                
                break
            case 10:
                cell.title?.text           = "专业"
                cell.TF?.placeholder       = "输入您的专业"
                
                break
            case 11:
                cell.title?.text           = "年级"
                cell.TF?.placeholder       = "输入您的年级"
                
                break
            case 15:
                cell.title?.text           = "推荐人"
                cell.TF?.placeholder       = "输入推荐人(选填)"
                
                break
            default:
                break
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

// ===================================================================================================================
// MARK: -
// ===================================================================================================================
extension SX_ApplyTrainListController {
    
    
    
}
