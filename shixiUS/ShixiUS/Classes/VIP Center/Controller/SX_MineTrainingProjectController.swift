//
//  SX_MineTrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请 ---> 实训项目

/*
 别为了不属于你的观众
 演绎你不擅长的人生
 反正谢幕后的每次相逢
 都有我捧着鲜花
 把你拥入怀中
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

let TRAININGCELLID = "tainingCellID"

class SX_MineTrainingProjectController: UIViewController {
    
    var noDataView: SX_NoDataView?
    var trainingApplyArr = [SX_TrainingApplyModel]()
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-80.FloatValue-kNavH)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        tableView.separatorStyle               = .none
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
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

// ============================================================================================
// MARK: - Other Method
// ============================================================================================
extension SX_MineTrainingProjectController {
    
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
        self.noDataView = SX_NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-40.FloatValue-kNavH)).addhere(toSuperView: table)
        self.noDataView?.isHidden = true
    }
    
    func fetchData() {
        let url = SX_MyApplyTraining + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))"
        
        SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
            do {
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    SXLog("成功!")
                    for item in json["data"].array ?? [] {
                        let trainingApplyModel = SX_TrainingApplyModel(jsonData: item)
                        self.trainingApplyArr.append(trainingApplyModel)
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
            }catch { }
        }
    }
}

// ============================================================================================
// MARK: - UITableViewDelegate
// ============================================================================================
extension SX_MineTrainingProjectController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.trainingApplyArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_MyApplyTrainingProjectCell(style: .default, reuseIdentifier: TRAININGCELLID)
        cell.selectionStyle         = .none
        let model                   = trainingApplyArr[indexPath.section]
        cell.projectTitle?.text     = model.title ?? "华尔街投行实地项目"
        cell.projectAddress?.text   = model.address ?? "Los Angles"
        cell.projectDate?.text      = model.time ?? "2018.03.03"
        //        cell.projectTime?.text      = "5Day"
        
        switch model.status {
        case "1"?:
            cell.projectContact?.isHidden = true
            cell.projectCancel?.isHidden  = true
            
            cell.projectPayAndRefund?.setTitle(model.button, for: .normal)
            cell.projectPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
            cell.projectPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
            cell.projectPayAndRefund?.backgroundColor   = UIColor.SX_MainColor()
            cell.projectPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
                SXLog("去支付 ++++")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            break
        default:
            
            cell.projectPayAndRefund?.isHidden            = true
            cell.projectCancel?.titleLabel?.font          = UIFont.boldSystemFont(ofSize: 12)
            cell.projectCancel?.titleLabel?.textAlignment = .center
            cell.projectCancel?.setTitle(model.button, for: .normal)
            cell.projectCancel?.setlineColor(color: UIColor.colorWithHexString(hex: "666666", alpha: 1))
            cell.projectCancel?.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            
            cell.projectCancel?.rx.tap.subscribe(onNext: { (_) in
                SXLog("取消申请 ++++")
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            cell.projectStyle?.text            = model.statusCn
            //cell.projectContact?.text          = "等待客服联系"
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
        SXLog("进入实训项目的申请详情")
        
//        let model = jobApplyArr[indexPath.section]
        self.hidesBottomBarWhenPushed = true
        let vc    = SX_TrainingApplyDetailController()
//        vc.number = model.id
        self.navigationController?.pushViewController(vc, animated: true)
        self.hidesBottomBarWhenPushed = false
    }
}
