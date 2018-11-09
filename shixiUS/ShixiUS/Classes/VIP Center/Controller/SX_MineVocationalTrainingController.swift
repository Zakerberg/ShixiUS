//
//  SX_MineVocationalTrainingController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 职业培训

/*
 我爱你
 又很遗憾没有人能证明
 可这份爱已经如鲸向海
 如鸟投林
 无可避免
 退无可退了
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

let vocationalCellID = "vocationalCellID"

class SX_MineVocationalTrainingController: SX_BaseController {
    
    var noDataView: SX_NoDataView?
    var trainApplyArr = [SX_TrainApplyModel]()
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-80.FloatValue-kNavH)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        tableView.separatorStyle               = .none
        
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

// ============================================================================================
// MARK: - Other Method
// ============================================================================================
extension SX_MineVocationalTrainingController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
    }
    
    func fetchData() {
        let url = SX_MyApplyTrain + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))"
        
        SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
            do {
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    SXLog("成功!")
                    for item in json["data"].array ?? [] {
                        let trainApplyModel = SX_TrainApplyModel(jsonData: item)
                        self.trainApplyArr.append(trainApplyModel)
                    }
                    self.table.reloadData()
                    if json["data"].count == 0 {
                        self.noDataView?.isHidden = false
                    }else{
                        self.noDataView?.isHidden = true
                    }
                }else{
                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                    hud.mode       = .text
                    hud.isSquare   = true
                    hud.label.text = json["msg"].string
                    hud.hide(animated: true, afterDelay: 1.0)
                }
                self.table.reloadData()
                self.hideLoadingView()
            }catch { }
        }
    }
}

// ============================================================================================
// MARK: - UITableViewDelegate
// ============================================================================================
extension SX_MineVocationalTrainingController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trainApplyArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_VocationalTrainingCell(style: .default, reuseIdentifier: vocationalCellID)
        cell.selectionStyle            = .none
        let model                      = trainApplyArr[indexPath.section]
        cell.vocationalTitle?.text     = model.title ?? "算法工程师培训"
        cell.vocationalPeriod?.text    = model.openclass ?? "第一期 | 2018-02-16"
        cell.vocationalDate?.text      = model.time ?? "2018.03.03"
        
        switch model.status {
        case "1"?:
            cell.vocationalContact?.isHidden = true
            cell.vocationalCancel?.isHidden  = true
            
            cell.vocationalPayAndRefund?.setTitle("去支付", for: .normal)
            cell.vocationalPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
            cell.vocationalPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.vocationalPayAndRefund?.backgroundColor  = UIColor.SX_MainColor()
            cell.vocationalPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
                SXLog("去支付 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            break
            
        default:
            cell.vocationalContact?.isHidden      = true
            cell.vocationalPayAndRefund?.isHidden = true
            
            cell.vocationalCancel?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 14)
            cell.vocationalCancel?.titleLabel?.textAlignment = .center
            cell.vocationalCancel?.setTitle("取消申请", for: .normal)
            cell.vocationalCancel?.setlineColor(color: UIColor.colorWithHexString(hex: "666666", alpha: 1))
            cell.vocationalCancel?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.vocationalCancel?.rx.tap.subscribe(onNext: { (_) in
                SXLog("职业培训取消申请 ++++")
                
                SX_NetManager.requestData(type: .GET, URlString: SX_ApplyCancel) { (result) in
                    do {
                        let json = try JSON(data: result)
                        if json["status"].int == 200 {
                            SXLog("取消申请成功!")
                         
                        }else{
                            
                        }
                    }catch { }
                }
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SXLog("进入就业岗位的申请详情")
        let model = trainApplyArr[indexPath.section]
        self.hidesBottomBarWhenPushed = true
        let vc    = SX_TrainApplyDetailController()
        vc.number = model.number
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}

