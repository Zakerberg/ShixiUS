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
import SwiftyJSON

let progressDetailCellID = "progressDetailCellID"

class SX_ApplyProgressDetailController: SX_BaseController {
    
    var progressArr = [SX_ApplyProgressDetailModel]()
    var typeStr: String?
    var url: String?
    var number: String?
    var stepsCnArr = [String]()
    
    lazy var tableView: UITableView = {
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
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================
// MARK: - Other Method
// ========================================================================
extension SX_ApplyProgressDetailController {
    
    func setUI() {
        title = "进度详情"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(tableView)
    }
    
    func fetchData() {
        
        if  self.typeStr == "training" {
            self.url = SX_Apply_TrainingProgress + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number ?? "")"
        }else if self.typeStr == "job" {
            self.url = SX_Apply_TrainProgress + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number ?? "")"
        }else {
            self.url = SX_Apply_JobProgress + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&number=\(self.number ?? "")"
        }
        
        SX_NetManager.requestData(type: .GET, URlString: self.url!, parameters:  nil, finishCallBack: { (result) in
            do{
                let json = try JSON(data: result)
                for item in json["data"].array ?? [] {
                    let progressModel = SX_ApplyProgressDetailModel(jsonData: item)
                    self.progressArr.append(progressModel)
                    self.stepsCnArr.append(item["stepsCn"].string ?? "")
                }
            } catch{ }
            self.tableView.reloadData()
            self.hideLoadingView()
        })
    }
}

// ========================================================================
// MARK: - UITableViewDelegate
// ========================================================================
extension SX_ApplyProgressDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.progressArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_ProgressDetailCell(style: .default, reuseIdentifier: progressDetailCellID)
        cell.selectionStyle = .none
        let model = self.progressArr[indexPath.section]
        if indexPath.section == 0 {
            cell.progressPoint?.image = UIImage(named: "icon")
        } else {
            cell.progressPoint?.image = UIImage(named: "icon1")
        }
        
        cell.steps?.text   = model.steps ?? "实习网测试Steps"
        cell.stepsCn?.text = model.stepsCn ?? "实习网测试StepsCn"

        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    
    
    }
}
