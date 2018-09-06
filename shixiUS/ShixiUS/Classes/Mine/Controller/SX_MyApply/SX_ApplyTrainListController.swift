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
    
    var dataArr = [Int](repeating: 0, count: 16)
    lazy var fixTable: UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor  = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled  = false
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
            
            return cell
        }else if indexPath.row == 5 || indexPath.row == 6 { // 单选按钮cell (是否有签证)
            
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            
            return cell
            
        }else{
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
            
            switch indexPath.row {
                
            case 1:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 2:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 3:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 4:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 7:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 8:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 9:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 10:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 11:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 12:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 15:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            case 16:
                cell.textLabel?.text = ""
                TF.placeholder       = ""
                
                break
            default:
                break
            }
            
            return cell
        }
    }
}

// ===================================================================================================================
// MARK: -
// ===================================================================================================================
extension SX_ApplyTrainListController {
    
    
    
}
