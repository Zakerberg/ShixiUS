//
//  SX_CertificationDetailController.swift
//  ShixiUS
//
//  Created by heather on 2018/10/19.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证详情

import UIKit
import SwiftyJSON

class SX_CertificationDetailController: UIViewController {
    var topArr = ["课程介绍", "课程大纲", "名师介绍"]
    
    var id: String?
    var moreDateBtn: UIButton?
    var serverImgs = [String]()
    var certificationDetailArr = JSON()
    
    /// 课程标题
    var classTitleArr  = [String]()
    /// 课程日期
    var classDateArr   = [String]()
    /// 课程价格
    var classPriceArr  = [String]()
    
    /// teacher 列表
    var teacherListArr = [TrainDetailTeacherModel]()
    
    lazy var pageTitleView: SX_PageTitleView = {
        let config                = SX_PageTitleViewConfig()
        config.titleColor         = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        config.titleSelectedColor = UIColor.SX_MainColor()
        let pageTitleView = SX_PageTitleView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 41), titles: self.topArr, config: config)
        pageTitleView.config      = config
        pageTitleView.titles      = self.topArr
        pageTitleView.pageTitleViewDelegate = self
        
        return pageTitleView
    }()
    
    var collectionBtn : UIButton?
    var applyBtn: UIButton?
    
    /// 主 TbaleView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-50.FloatValue.IPAD_XValue), style: .grouped)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavH), 0, 0, 0);
        table.delegate     = self
        table.dataSource   = self 
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    lazy var detailScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .SERVER, imgs: self.serverImgs, descs: nil)
        cycleView.delegate = self
        
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setUI()
    }
    
    deinit {
        tableView.delegate = nil
        print("培训详情VC deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==============================================================================
// MARK: - Other Method
// ==============================================================================
extension SX_CertificationDetailController {
    func setUI() {
        view.backgroundColor = UIColor.white
        //self.setRightItem("share")
        self.setLeftItem("leftBack")
        
        view.addSubview(tableView)
        tableView.addSubview(detailScrollerView)
        navBarBackgroundAlpha = 0
        
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
                if self.collectionBtn?.isSelected == true {
                    SXLog("已收藏,点击取消收藏")
                    self.collectionBtn?.isSelected = false
                }else {
                    SXLog("未收藏,点击收藏职位")
                    self.collectionBtn?.isSelected = true
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
            APPLY.titleLabel?.font    = UIFont.boldSystemFont(ofSize: 15)
            APPLY.setTitle("申请报名", for: .normal)
            APPLY.rx.tap.subscribe(onNext: { (_) in
                SXLog("立即申请 +++ + ")
                
                ///加判断
                
                let vc =  SX_ApplyTrainListController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })
    }
    
    func fetchData() {
        
        SX_NetManager.requestData(type: .GET, URlString: (SX_TrainDetail + self.id!), parameters:  nil, finishCallBack: { (result) in
            do{
                
                let json = try JSON(data: result)
                self.certificationDetailArr = JSON(arrayLiteral: json.dictionary ?? [:])
                self.serverImgs.append(json["data"]["image"].string!)
                self.detailScrollerView.serverImgArray = self.serverImgs
                
                for item in json["data"]["series"].array ?? [] {
                    self.classTitleArr.append(item["name"].string ?? "")
                }
                
                for item in json["data"]["courseprice"].array ?? [] {
                    self.classDateArr.append(item["date"].string ?? "")
                    self.classPriceArr.append(item["price"].string ?? "")
                }
                
                for item in json["data"]["teacher"].array ?? [] {
                
                    
                }

                self.detailScrollerView.reloadData()
                self.tableView.reloadData()
                
            } catch{ }
        })
    }
}

// ==============================================================================
// MARK: -  UITableViewDelegate
// ==============================================================================
extension SX_CertificationDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let titleCell = SX_ProjectDetailTitleCell(style: .default, reuseIdentifier: projectDetailTitleCellID)
            titleCell.selectionStyle = .none
            let model = self.certificationDetailArr[indexPath.section]
            
            titleCell.projectName?.text    = model["data"]["title"].string ?? ""
            titleCell.projectContent?.text = "主讲老师: " + (model["data"]["teacher_name"].string ?? "")
            titleCell.projectCity?.text    = "授课地点: " + (model["data"]["address"].string ?? "")
            
            titleCell.projectPrice?.text   = "¥" + ("1500") + "起/人"
            
            return titleCell
            
        }else if indexPath.section == 1 {
            let cell = SX_ProjectTripDateCell(style: .default, reuseIdentifier: "TRIPDATACELL")
            cell.selectionStyle = .none
            
            self.moreDateBtn    = cell.moreDate
            self.moreDateBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("更多日期 ")
                
                let vc = SX_MoreDateController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil).dispose()
            
            return cell
        }
        
        let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: projectDetailCellID)
        cell.selectionStyle = .none
        
        if indexPath.section == 2 {
            cell.titleLabel?.text  = "课程介绍"
        }else if indexPath.section == 3 {
            cell.titleLabel?.text  = "课程大纲"
        }else{
            cell.titleLabel?.text  = "名师介绍"
        }
        
        cell.titleLabel?.textAlignment = .center
        // cell.contentLabel?.text        = self.ProjectLightStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 120.FloatValue.IPAD_XValue
        case 1:
            return 190.FloatValue.IPAD_XValue
        default:
            return 100.FloatValue.IPAD_XValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if  section == 2 {
            return 40.FloatValue.IPAD_XValue
        }
        return 5.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            let view = self.pageTitleView
            tableView.tableHeaderView?.addSubview(view)
            
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ==============================================================================
// MARK: - SXCycleScrollerViewDelegate
// ==============================================================================
extension SX_CertificationDetailController: SXCycleScrollerViewDelegate {
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
        
    }
}

// ==============================================================================
// MARK: - SXPageTitleViewDelegate
// ==============================================================================
extension SX_CertificationDetailController: SXPageTitleViewDelegate {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        
        
    }
}

// ==============================================================================
// MARK: - UIScrollViewDelegate
// ==============================================================================
extension SX_CertificationDetailController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT) {
            changeNavBarAnimateWithIsClear(isClear: false)
            title = "项目详情"
        } else {
            changeNavBarAnimateWithIsClear(isClear: true)
            title = ""
        }
        
        // 限制下拉距离
        if (offsetY < LIMIT_OFFSET_Y) {
            scrollView.contentOffset = CGPoint.init(x: 0, y: LIMIT_OFFSET_Y)
        }
        
        // 改变图片框的大小 (上滑的时候不改变)
        // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
        let newOffsetY = scrollView.contentOffset.y
        
        if (newOffsetY < -IMAGE_HEIGHT) {
            detailScrollerView.frame = CGRect(x: 0, y: newOffsetY, width: SCREEN_WIDTH, height: -newOffsetY)
        }
    }
    
    private func changeNavBarAnimateWithIsClear(isClear:Bool) {
        UIView.animate(withDuration: 0.5, animations: { [weak self] in
            if let weakSelf = self
            {
                if (isClear == true) {
                    weakSelf.navBarBackgroundAlpha = 0
                } else {
                    weakSelf.navBarBackgroundAlpha = 1.0
                }
            }
        })
    }
}
