//
//  SX_CollectionVocationalTrainingController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/3.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的收藏 --> 职业培训

/*
 我爱你
 若以朋友的身份可以一直在你身边
 陪你笑
 陪你疯
 陪你哭
 这样一辈子
 就挺好
 */

import UIKit
import MBProgressHUD
import SwiftyJSON

let collectionVocationCellID = "collectionVocationCellID"

class SX_CollectionVocationalTrainingController: SX_BaseController {
    
    var noDataView: SX_NoDataView?
    var TrainingArr  = [TrainingCollectionListModel]()
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-40.FloatValue-kNavH)), style: .grouped)
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

// ===============================================================================
// MARK: - Other Method
// ===============================================================================
extension SX_CollectionVocationalTrainingController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
        self.noDataView = SX_NoDataView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-40.FloatValue-kNavH)).addhere(toSuperView: table)
        self.noDataView?.isHidden = true
    }
    
    func fetchData() {
        
        let url = SX_VIPCenter_MyCollection + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" + "&type=3"
        
        SX_NetManager.requestData(type: .GET, URlString: url) { (result) in
            do {
                let json = try JSON(data: result)
                if json["status"].int == 200 {
                    SXLog("获取实训项目收藏成功!")
                    for item in json["data"]["lists"].array ?? [] {
                        let TrainingModel = TrainingCollectionListModel(jsonData: item)
                        self.TrainingArr.append(TrainingModel)
                    }
                    self.table.reloadData()
                    if json["data"]["lists"].count == 0 {
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
                self.hideLoadingView()
            }catch { }
        }
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_CollectionVocationalTrainingController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.TrainingArr.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_VocationalTrainingCell(style: .default, reuseIdentifier: vocationalCellID)
        cell.selectionStyle            = .none
        
        let model                      = TrainingArr[indexPath.section]
        
        cell.vocationalTitle?.text     = model.title ?? "算法工程师培训(测试)"
        cell.vocationalPeriod?.text    = model.time ?? "第一期 | 2018-02-16(测试)"
        //        cell.vocationalDate?.text      = "2018.03.03(测试)"
        
        cell.vocationalContact?.isHidden = true
        cell.vocationalCancel?.isHidden  = true
        
        cell.vocationalPayAndRefund?.setTitle("立即申请", for: .normal)
        cell.vocationalPayAndRefund?.titleLabel?.font  = UIFont.boldSystemFont(ofSize: 12)
        cell.vocationalPayAndRefund?.setTitleColor(UIColor.white, for: .normal)
        cell.vocationalPayAndRefund?.backgroundColor   = UIColor.colorWithHexString(hex: "72a21b", alpha: 1)
        cell.vocationalPayAndRefund?.rx.tap.subscribe(onNext: { (_) in
            SXLog("职位培训的立即申请 ++++")
            let vc = SX_ApplyVocationListController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
        
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
        tableView.deselectRow(at: indexPath, animated: true)
        let model = TrainingArr[indexPath.row]
        let vc    = SX_CertificationDetailController()
        vc.id     = model.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
