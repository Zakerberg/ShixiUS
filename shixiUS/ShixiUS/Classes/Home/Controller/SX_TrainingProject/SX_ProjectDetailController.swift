//
//  SX_ProjectDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/18/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目详情

/*
 就算你一身污秽如刺猬
 也有我双手拥抱不忌讳
 */

import UIKit

let projectDetailTitleCellID    = "projectDetailTitleCellID"
let projectDetailDateTripCellID = "projectDetailDateTripCellID"

let projectDetailCellID = "projectDetailCellID"

/// 悬浮view的高度
let verticaListViewHeight: CGFloat = 60
/// 悬浮固定Section的index
let verticaListSectionIndex = 1

class SX_ProjectDetailController: UIViewController {
    
    ///////////////////////////////////////////////////////////////////////////////////////////////
    var Arr = ["项目亮点", "日程安排", "费用说明", "预定须知"]
    var ProjectLightStr = "Overriding declaration requires an 'override' keywordOverriding declaration requires an 'override' keywordOverriding declaration requires an 'override' keywordOverriding declaration requires an 'override' keywordOverriding declaration requires an 'override' keywordOverriding declaration requires an 'override' keyword"
    
    var tripTitleArr = ["行程A", "行程B", "行程C", "行程D"]
    
    var dateTArr     = ["06.12", "06.14", "08.19", "09.16"]
    var priceTArr    = ["¥5818", "¥5555", "¥1234", "¥7892"]
    ///////////////////////////////////////////////////////////////////////////////////////////////
    
    var collectionBtn : UIButton?
    var applyBtn: UIButton?
    
    /// 主 TbaleView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-50.FloatValue.IPAD_XValue), style: .grouped)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavH), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        table.showsVerticalScrollIndicator = false
        table.tableFooterView = UIView()
        
        return table
    }()
    
    /// 项目详情的轮播
    lazy var detailScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .LOCAL, imgs: nil, descs: nil)
        cycleView.delegate = self
        
        return cycleView
    }()
    
    lazy var projectBgView: UIView = {
        let projectBgView = UIImageView(image: UIImage.init(named: "Bg")).addhere(toSuperView: self.tableView).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.detailScrollerView.snp.bottom).offset(-20)
            make.height.equalTo(Margin+10)
            make.width.equalToSuperview()
        }).config({ (projectBgView) in
            
        })
        return projectBgView
    }()
    
    lazy var headerBtnView: UIView = {
        
        let headerBtnView = UIView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (headerBtnView) in
            
        })
        
        return headerBtnView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setUI()
    }
    
    deinit {
        tableView.delegate = nil
        print("项目详情VC deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================================================
// MARK: - Other Method
// ========================================================================================================
extension SX_ProjectDetailController {
    
    func setUI() {
        view.backgroundColor = UIColor.white
        self.setRightItem("share")
        self.setLeftItem("leftBack")
        
        let localImgs = ["localImg4","localImg6","localImg3"]
        
        detailScrollerView.localImgArray = localImgs
        view.addSubview(tableView)
        tableView.addSubview(detailScrollerView)
        tableView.addSubview(projectBgView)
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
            
            COLLECTION.addTarget(self, action: #selector(collectionBtnClick), for: .touchUpInside)
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
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })        
    }
    
    func fetchData() {
        
        
        
        
    }
}

// =======================================================================================================
// MARK: - UITableViewDelegate
// =======================================================================================================
extension SX_ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let titleCell = SX_ProjectDetailTitleCell(style: .default, reuseIdentifier: projectDetailTitleCellID)
            titleCell.selectionStyle = .none
            // MARK: - 接口 --------
            titleCell.projectName!.text = "联合国新兴全球领导人和公民培养计划-测试"
            titleCell.projectContent!.text = "包含:课程,签证,机票,活动,食宿,保险 - 测试"
            titleCell.projectCity!.text = "出发城市: 北京 - 测试"
            titleCell.projectPrice!.text = "$" + "1500" + "起/人"
            
            return titleCell
            
        } else if indexPath.section == 1 {
            let cell = SX_ProjectTripDateCell()
            cell.selectionStyle = .none
            // MARK: - 接口 --------
            cell.tripArr      = self.tripTitleArr
            cell.dateArr      = self.Arr
            
            
            cell.dateTArr     = self.dateTArr
            cell.priceTArr    = self.priceTArr
            // MARK: - 接口 --------
            
            
            cell.tripBtn?.addTarget(self, action: #selector(tripBtnClick), for: .touchUpInside)
            

            
            cell.dateBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("出发日期 按钮的点击 +++ + ")
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
            
            
            return cell
        }
        
        let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: projectDetailCellID)
        cell.selectionStyle = .none
        
        if indexPath.section == 2 {
            cell.titleLabel?.text = "项目亮点"
        }else if indexPath.section == 3 {
            
            cell.titleLabel?.text = "日程安排"
        }else if indexPath.section == 4 {
            cell.titleLabel?.text = "费用说明"
        }else{
            cell.titleLabel?.text = "预定须知"
        }
        
        cell.titleLabel?.textAlignment = .center
        cell.contentLabel?.text = self.ProjectLightStr
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 135.FloatValue.IPAD_XValue
            
        case 1:
            return 185.FloatValue.IPAD_XValue
        default:
            return UILabel.SX_getSpaceLabelHeight(self.ProjectLightStr as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ===========================================================================================================
// MARK: - SXCycleScrollerViewDelegate
// ==========================================================================================================
extension SX_ProjectDetailController: SXCycleScrollerViewDelegate {
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        SXLog("点击了实训项目详情轮播的\(index)")
    }
}

// ==========================================================================================================
// MARK: - UIScrollViewDelegate
// ===========================================================================================================
extension SX_ProjectDetailController: UIScrollViewDelegate {
    
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
                }
                else {
                    weakSelf.navBarBackgroundAlpha = 1.0
                }
            }
        })
    }
}

// =========================================================================================================
// MARK: - @objc 收藏
// =========================================================================================================
extension SX_ProjectDetailController {
    @objc func collectionBtnClick() {
        
        if self.collectionBtn?.isSelected == true {
            SXLog("已收藏,点击取消收藏")
            self.collectionBtn?.isSelected = false
        }else {
            SXLog("未收藏,点击收藏职位")
            self.collectionBtn?.isSelected = true
        }
    }
}

// =========================================================================================================
// MARK: - @objc 行程Btn
// =========================================================================================================
extension SX_ProjectDetailController {
    @objc func tripBtnClick(btn: UIButton) {
    
        SXLog(btn.tag)
 
        for index in 0...self.tripTitleArr.count {
            let button = self.view.viewWithTag(100+index) as? UIButton
            if button?.tag != btn.tag {
                button?.isSelected = false
            }else{
                button?.isSelected = true
            }
        }
    }
}
