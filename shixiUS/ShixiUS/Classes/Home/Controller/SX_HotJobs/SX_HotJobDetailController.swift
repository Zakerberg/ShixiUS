//
//  SX_HotJobDetailController.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位详情

/*
 我无法确定你是否把我推开
 我可以确定的是
 无论你把我推开多少次
 我都会回来
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

let hotJobDetailCellID = "hotJobDetailCellID"
let hotJobContentDetailCellID = "hotJobContentDetailCellID"

class SX_HotJobDetailController: SX_BaseController {
    
    var dataArr = "1. 加入酷炫拽的华尔街金融和媒体圈子，可认识美国行业专家和华尔街金融人士，打造在美国的资源人脉\n 2. 可获得美国公司跨境新媒体工作经验和推荐信，并优先获得长期职位和推荐职位 \n 3. 获得海外精英教育和海外投资专业知识，接受相关专业知识培训； \n 4. 获得新媒体创业和创富机会。公司实现课程专题创业项目制，每个员工包括实习生可以自己提议选题和推荐主讲人，经公司专题组同意后和主讲人合作开始制作音频课程然后销售。项目负责人以及团队可获得课程销售的10%作为项目提成，实现新媒体创业并创富."
    
    var DATA = "1）传媒，广告，新闻，文学，艺术和电影等相关专业；\n 2）具有媒体音频视频策划剪辑制作经验，具有新闻传媒写作编辑和新媒体运营和市场拓展经验 ；\n 3）熟悉国内知名内容平台和音频视频平台，具有良好网感；\n 4）对新媒体行业有热情愿意学习并积极主动全心投入工作。"
    
    var collectionBtn : UIButton?
    var applyBtn: UIButton?
    
    var id:String?
    var detailModels = [SX_JobDetailModel]()
    
    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT-50.FloatValue.IPAD_XValue)), style: .grouped)
        tableView.backgroundColor              = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate                     = self
        tableView.dataSource                   = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setUI()
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==========================================================
// MARK: - Other Method
// ==========================================================
extension SX_HotJobDetailController {
    func setUI() {
        title = "热门岗位"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(table)
        
        self.collectionBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(SCREEN_WIDTH/2)
        }).config({ (COLLECTION) in
            COLLECTION.setImage(#imageLiteral(resourceName: "icon_hotJob_collection"), for: .normal)
            COLLECTION.setImage(#imageLiteral(resourceName: "icon_hotJob_collectionHL"), for: .selected)
            COLLECTION.setTitle("  收藏", for: .normal)
            COLLECTION.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            COLLECTION.setTitleColor(UIColor.colorWithHexString(hex: "999999", alpha: 1), for: .normal)
            COLLECTION.setTitleColor(UIColor.SX_MainColor(), for: .selected)
            COLLECTION.rx.tap.subscribe(onNext: { (_) in
                // 判断登陆
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    /// token & userid 获取拼接
                    let url = SX_VIPCenter_Add + "token=\(String(describing: USERDEFAULTS.value(forKey: "token")!))" + "&userId=\(String(describing: USERDEFAULTS.value(forKey: "userId")!))" +  "&collection_type=job" + "&id=\(self.id!)"
                    
                    SX_NetManager.requestData(type: .GET, URlString: url, finishCallBack: { (result) in
                        do{
                            let json = try JSON(data: result)
                            if json["status"].int == 200 {
                                if self.collectionBtn?.isSelected == true {
                                    SXLog("已收藏")
                                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    hud.mode       = .text
                                    hud.isSquare   = true
                                    hud.label.text = "已收藏"
                                    hud.hide(animated: true, afterDelay: 1.0)
                                    self.collectionBtn?.isSelected = false
                                }else {
                                    SXLog("取消收藏")
                                    let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    hud.mode       = .text
                                    hud.isSquare   = true
                                    hud.label.text = "取消收藏"
                                    hud.hide(animated: true, afterDelay: 1.0)
                                    self.collectionBtn?.isSelected = true
                                }
                            }else{ // 登录超时
                                let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                                hud.mode       = .text
                                hud.isSquare   = true
                                hud.label.text = json["msg"].string
                                hud.hide(animated: true, afterDelay: 2.0)
                                self.present(SX_LoginController(), animated: true, completion: nil)
                            }
                        } catch{ }
                    })
                }
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
        
        self.applyBtn = UIButton(type: .custom).addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.right.bottom.equalToSuperview()
            make.height.width.equalTo(self.collectionBtn!)
        }).config({ (APPLY) in
            APPLY.backgroundColor     = UIColor.SX_MainColor()
            APPLY.titleLabel?.font    = UIFont.systemFont(ofSize: 15)
            APPLY.setTitle("立即申请", for: .normal)
            APPLY.rx.tap.subscribe(onNext: { (_) in
                SXLog("立即申请 +++ + ")
                
                /// 此处判断token 登录判断
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    self.present(SX_LoginController(), animated: true, completion: nil)
                }else{
                    let vc   = SX_ApplyEmpListController()
                    vc.jobid = self.id
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
    }
    
    func fetchData() {
        
        SX_NetManager.requestData(type: .GET, URlString: (SX_JobDetail + self.id!), parameters:  nil, finishCallBack: { (result) in
            do{
                /// SwiftyJSON 在这里 ! ! !
                let json = try JSON(data: result)
                SXLog("成功!")
                let model = SX_JobDetailModel(jsonData: json)
                self.detailModels.append(model)
                
                self.id = json["data"]["id"].string ?? "250"
                self.hideLoadingView()
                self.table.reloadData()
            } catch{ }
        })
    }
}

// ==========================================================
// MARK: -  UITableViewDelegate
// ==========================================================
extension SX_HotJobDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = SX_HotJobDetailCell(style: .default, reuseIdentifier: hotJobDetailCellID)
            cell.selectionStyle       = .none
            
            let model = detailModels[indexPath.row]
            
            cell.jobName?.text        = model.title ?? "美国金融测试岗位"
            cell.jobReleaseTime?.text = model.time ?? "测试时间"
            cell.jobIndustry?.text    = model.trade_name ?? "测试"
            cell.jobPlace?.text       = model.address ?? "美国/测试/洛杉矶"
            cell.jobPeopleCount?.text = (model.amount ?? "10(测试)") + "人"
            cell.jobFullTime?.text    = model.duration_name ?? "全职测试"
            cell.jobInterShip?.text   = model.nature_name ?? "实习测试"
            cell.jobSalary?.text      = model.wages ?? "面议"
            
            return cell
        }
        
        let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: hotJobContentDetailCellID)
        cell.selectionStyle  = .none
        
        let model = detailModels[indexPath.row]
        
        if indexPath.section == 1 {
            cell.titleLabel?.text   = "工作职责"
            cell.contentLabel?.text = model.duty ?? self.dataArr
        }else if indexPath.section == 2{
            cell.titleLabel?.text   = "应聘要求"
            cell.contentLabel?.text = model.requirement ?? self.DATA
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110.FloatValue.IPAD_XValue
        } else if indexPath.section == 1 {
            return UILabel.SX_getSpaceLabelHeight(self.dataArr as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
        }
        return UILabel.SX_getSpaceLabelHeight(self.DATA as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 5.FloatValue.IPAD_XValue
    }
}
