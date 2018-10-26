//
//  SX_ApplyDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/8/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  申请详情界面

/*
 听过最撩人的一句话:
 我之前没有爱过别人
 你是第一个
 我怕我做的不好
 让你觉得
 爱情不过如此
 */

import UIKit

let applyDetailCellID = "applyDetailCellID"
let detailCellID      = "detailCellID"

class SX_ApplyDetailController: UIViewController {
    
    var detailPriceLabel : UILabel?  // 价格
    var payBtn           : UIButton? // 支付服务预定金
    var cancelBtn        : UIButton? // 取消订单
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        
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

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_ApplyDetailController {
    
    func setUI() {
        title = "申请详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyDetailController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 2 {
            return 5
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = SX_ApplyProgressCell(style: .default, reuseIdentifier: nil)
            cell.accessoryType             = .disclosureIndicator
            cell.selectionStyle            = .none
            cell.progressNormalBgView?.isHidden = false
            cell.progressBgView?.isHidden  = true  // 1
            cell.progressStatus?.text      = "等待客服联系这是测试的数据为了显示换行,确实要换行啊,还要多少字?换行了吧!"
            cell.progressTime?.text        = "2018-07-10 20:55:00"
            cell.progressRejected?.text    = "退款申请被驳回,有问题联系客服" // 1
            
            return cell
            
        } else if indexPath.section == 1 {
            
            let cell = SX_EmploymentJobsCell(style: .default, reuseIdentifier: applyDetailCellID)
            cell.backgroundColor           = UIColor.white
            cell.selectionStyle            = .none
            cell.lineView?.isHidden        = true
            
            cell.employmentTitle?.text     = "美国金融实习岗位-信托和过桥基金业务"
            cell.employmentDate?.text      = "2018.03.03"
            cell.employmentAddress?.text   = "美国/纽约"
            cell.employmentNature?.text    = "正式"
            
            return cell
        } else {
            
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: detailCellID)
            cell.backgroundColor = UIColor.white
            
            self.detailPriceLabel = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.height.equalTo(20.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (PRICE) in
                PRICE.sizeToFit()
            })
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text                   = "美国金融实习岗位"
                cell.textLabel?.font                   = UIFont.systemFont(ofSize: 16)
                cell.textLabel?.textColor              = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 1:
                cell.textLabel?.text                   = "服务费用总额"
                cell.textLabel?.font                   = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor              = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.detailPriceLabel?.text            = "$500.00"
                self.detailPriceLabel?.font            = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor       = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 2:
                cell.textLabel?.text                   = "预定金"
                cell.textLabel?.font                   = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor              = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.detailPriceLabel?.text            = "$100.00"
                self.detailPriceLabel?.font            = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor       = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 3:
                cell.textLabel?.text                   = "状态"
                cell.textLabel?.font                   = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor              = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                
                self.detailPriceLabel?.text            = "未支付"
                self.detailPriceLabel?.font            = UIFont.systemFont(ofSize: 14)
                self.detailPriceLabel?.textColor       = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                break
            case 4:
                cell.textLabel?.text                   = "应付定金"
                cell.textLabel?.font                   = UIFont.systemFont(ofSize: 14)
                cell.textLabel?.textColor              = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                
                self.detailPriceLabel?.text            = "$100.00"
                self.detailPriceLabel?.font            = UIFont.boldSystemFont(ofSize: 18)
                self.detailPriceLabel?.textColor       = UIColor.colorWithHexString(hex: "fc1614", alpha: 1)
                
                break
            default:
                break
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 2 {
            let view = UIView()
            
            self.payBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview().offset(Margin)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(50.FloatValue.IPAD_XValue)
            }).config({ (PAY) in
                PAY.backgroundColor     = UIColor.SX_MainColor()
                PAY.layer.masksToBounds = true
                PAY.layer.cornerRadius  = 5
                PAY.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 18)
                PAY.setTitle("支付服务预定金", for: .normal)
                PAY.setTitleColor(UIColor.white, for: .normal)
                PAY.rx.tap.subscribe(onNext: { (_) in
                    SXLog("支付服务预定金 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            self.cancelBtn = UIButton(type: .custom).addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.payBtn!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.height.left.right.equalTo(self.payBtn!)
            }).config({ (CANCEL) in
                CANCEL.backgroundColor     = UIColor.colorWithHexString(hex: "cccccc", alpha: 1)
                CANCEL.layer.masksToBounds = true
                CANCEL.layer.cornerRadius  = 5
                CANCEL.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 18)
                CANCEL.setTitle("取消订单", for: .normal)
                CANCEL.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
                CANCEL.rx.tap.subscribe(onNext: { (_) in
                    SXLog("取消订单 +++ + ")
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
            })
            
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return UILabel.SX_getSpaceLabelHeight("等待客服联系这是测试的数据为了显示换行,确实要换行啊,还要多少字?换行了吧!", font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 80
        } else if indexPath.section == 1{
            return 80.FloatValue.IPAD_XValue
        }
        
        return 45.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 2 {
            return 120.FloatValue.IPAD_XValue
        }
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            SXLog("进入申请进度详情界面")
            let vc = SX_ApplyProgressDetailController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

