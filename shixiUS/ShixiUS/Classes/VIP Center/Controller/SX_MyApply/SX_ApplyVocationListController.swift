//
//  SX_ApplyVocationListController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/5.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  职位培训的申请表

/*
 我把曾经写过的诗撕碎
 字迹还能找回
 每首诗里，都有你
 */

import UIKit

class SX_ApplyVocationListController: UIViewController {
    
    var dataArr = [Int](repeating: 0, count: 10)
    var confirmBtn: UIButton?
    
    var sexStr: String?
    /// 性别Arr
    var sexArr :Array = { () -> [[String : String]] in
        let arr3 = [["title":"男", "value":"1"],
                    ["title":"女", "value":"0"]]
        
        return arr3
    }()
    
    lazy var table: UITableView    = {
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

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_ApplyVocationListController {
    
    func setUI() {
        title = "实训项目申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyVocationListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 { /// 标题: 全球公民学院
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            cell.textLabel?.text          = "电子商务师"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font          = UIFont.boldSystemFont(ofSize: 16)
            cell.textLabel?.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
            
            return cell
        } else if indexPath.row == 2 { // 单选按钮 (男女)
            let cell = SX_ApplyVisaCell(style: .default, reuseIdentifier: nil)
            cell.selectionStyle = .none
            
            cell.title?.text = "性别"
            for index in 0...1 {
                let _ = UIButton(type: .custom).addhere(toSuperView: cell.contentView).layout { (make) in
                    make.centerY.equalToSuperview()
                    make.width.equalTo(60.FloatValue.IPAD_XValue)
                    make.height.equalTo(28.FloatValue.IPAD_XValue)
                    make.left.equalTo(cell.title!.snp.right).offset(CGFloat(index) * 80.FloatValue.IPAD_XValue + 10.FloatValue.IPAD_XValue)
                    }.config { (BTN) in
                        BTN.setTitle(self.sexArr[index]["title"], for: .normal)
                        BTN.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                        BTN.setTitleColor(UIColor.SX_MainColor(), for: .selected)
                        BTN.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                        BTN.titleLabel?.font          = UIFont.systemFont(ofSize: 13)
                        BTN.titleLabel?.textAlignment = .center
                        BTN.tag                       = index+1000
                        BTN.layer.cornerRadius        = 5
                        BTN.layer.borderColor         = UIColor.init(white: 0.6, alpha: 1).cgColor
                        BTN.layer.borderWidth         = 0.6
                        if index == 0{
                            BTN.isSelected            = true
                            BTN.layer.borderColor     = UIColor.SX_MainColor().cgColor
                        }
                        
                        BTN.addTarget(self, action: #selector(BtnClick), for: .touchUpInside)
                }
            }
            
            return cell
            
        } else if indexPath.row == 4 { // 学历选择
            let cell = SX_ApplyAddressCell(style: .default, reuseIdentifier: applyAddressCellID)
            cell.selectionStyle = .none
            cell.title?.text    = "学历"
            
            
            return cell
        } else {
            let cell = SX_ApplyMessageCell(style: .default, reuseIdentifier: applyListIdentifier)
            cell.selectionStyle            = .none
            
            switch indexPath.row {
                
            case 1:
                cell.title?.text           = "姓名"
                cell.TF?.placeholder       = "输入您的姓名"
                
                break
            case 3:
                cell.title?.text           = "身份证"
                cell.TF?.placeholder       = "输入您的身份证号"
                cell.TF?.keyboardType      = .phonePad
                
                break
            case 5:
                cell.title?.text           = "学校"
                cell.TF?.placeholder       = "输入您的学校"
                
                break
            case 6:
                cell.title?.text           = "工作单位"
                cell.TF?.placeholder       = "输入您的工作单位"
                
                break
            case 7:
                cell.title?.text           = "手机"
                cell.TF?.placeholder       = "输入您的手机"
                
                break
            case 8:
                cell.title?.text           = "微信"
                cell.TF?.placeholder       = "输入您的微信"
                
                break
            case 9:
                cell.title?.text           = "邮箱"
                cell.TF?.placeholder       = "输入您的邮箱"
                
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
        let view = UIView()
        self.confirmBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
            make.top.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.height.equalTo(45.FloatValue.IPAD_XValue)
        }).config({ (CONFIRM) in
            CONFIRM.backgroundColor     = UIColor.SX_MainColor()
            CONFIRM.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 20)
            CONFIRM.setTitle("确定", for: .normal)
            CONFIRM.layer.masksToBounds = true
            CONFIRM.layer.cornerRadius  = 10
            CONFIRM.rx.tap.subscribe(onNext: { (_) in
                SXLog("培训认证的确定申请 +++ + ")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80.FloatValue.IPAD_XValue
    }
}

// ========================================================================
// MARK: - @objc
// ========================================================================
extension SX_ApplyVocationListController {
    @objc func BtnClick(btn: UIButton) {
        for index in 0...1 {
            let button = self.view.viewWithTag(1000+index) as? UIButton
            
            if button?.tag != btn.tag {
                button?.layer.borderColor = UIColor.init(white: 0.6, alpha: 1).cgColor
                button?.layer.borderWidth = 0.6
                button?.isSelected        = false
            }else{
                button?.layer.borderColor = UIColor.SX_MainColor().cgColor
                button?.setBackgroundImage(#imageLiteral(resourceName: "Apply_hook"), for: .selected)
                button?.layer.borderWidth = 0.6
                button?.isSelected        = true
                let dic = self.sexArr[index] as [String:String]
                self.sexStr = dic["value"]
                SXLog(sexStr)
            }
        }
    }
}
