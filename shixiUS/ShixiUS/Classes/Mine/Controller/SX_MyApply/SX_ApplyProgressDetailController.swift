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
    
    var progressTitleArr  = ["支付尾款, 获取入职通知", "完成面试, 等待回馈", "预定金已经支付", "就业顾问已沟通", "申请提交成功"]
    var progressDesArr    = ["恭喜您入职成功!", "请耐心等待企业反馈, 祝您入职成功", "您的申请已经发生, 因为人力公司回馈,请耐心等待面试通知,===您的申请已经发生, 因为人力公司回馈,请耐心等待面试通知---您的申请已经发生, 因为人力公司回馈,请耐心等待面试通知", "", "等待我们的就业顾问联系您,进一步了解您的求职意向,帮助您更好的向企业进行推荐,以获得面试机会"]
    
    
    lazy var progressTab: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
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

// ======================================================================================================================
// MARK: - Other Method
// ======================================================================================================================
extension SX_ApplyProgressDetailController {
    
    func setUI() {
        title = "进度详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(progressTab)
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
        let cell = SX_ProgressDetailCell(style: .default, reuseIdentifier: progressDetailCellID)
        cell.selectionStyle = .none
        
        switch indexPath.row {
        case 0:
           cell.progressTitle?.text      = self.progressTitleArr[indexPath.row]
           cell.progressTitle?.textColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
           
           cell.progressDes?.text        = self.progressDesArr[indexPath.row]
           cell.progressDes?.textColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
           
            break
        case 1:
            cell.progressTitle?.text      = self.progressTitleArr[indexPath.row]
            cell.progressTitle?.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            
            cell.progressDes?.text        = self.progressDesArr[indexPath.row]
            cell.progressDes?.textColor   = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            break
        case 2:
            cell.progressTitle?.text      = self.progressTitleArr[indexPath.row]
            cell.progressTitle?.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            
            cell.progressDes?.text        = self.progressDesArr[indexPath.row]
            cell.progressDes?.textColor   = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            break
        case 3:
            cell.progressTitle?.text      = self.progressTitleArr[indexPath.row]
            cell.progressTitle?.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            
            cell.progressDes?.text        = self.progressDesArr[indexPath.row]
            cell.progressDes?.textColor   = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            break
        case 4:
            cell.progressTitle?.text      = self.progressTitleArr[indexPath.row]
            cell.progressTitle?.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            
            cell.progressDes?.text        = self.progressDesArr[indexPath.row]
            cell.progressDes?.textColor   = UIColor.colorWithHexString(hex: "999999", alpha: 1)
            
            break
        default:
            break
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UILabel.SX_getSpaceLabelHeight(self.progressDesArr[indexPath.row] as NSString, font: UIFont.systemFont(ofSize: 14), width: 200, space: 0, zpace: 0) + 50.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.FloatValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.FloatValue
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




