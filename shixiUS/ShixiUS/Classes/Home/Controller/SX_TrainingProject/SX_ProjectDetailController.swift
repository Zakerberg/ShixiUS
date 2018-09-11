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
class SX_ProjectDetailController: UIViewController {
    
    var row:NSInteger?
    
// ============================================================================================================================
// MARK: - Lazy
// ===========================================================================================================================
    
    /// 主 TbaleView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-kTabBarHeight), style: .grouped)
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
        view.backgroundColor = UIColor.white
        self.setRightItem("share")
        self.setLeftItem("leftBack")
        
        let localImgs = ["localImg4","localImg6","localImg3"]
        
        detailScrollerView.localImgArray = localImgs
        view.addSubview(tableView)
        tableView.addSubview(detailScrollerView)
        tableView.addSubview(projectBgView)
        navBarBackgroundAlpha = 0
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

// =============================================================================================================================
// MARK: - Other Method
// ===========================================================================================================================
extension SX_ProjectDetailController {
    
    func fetchData() {
        
        
        
        
        
        
        
    }
}

// ============================================================================================================================
// MARK: - UITableViewDelegate
// ============================================================================================================================
extension SX_ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let titleCell = SX_ProjectDetailTitleCell(style: .default, reuseIdentifier: projectDetailTitleCellID)
            titleCell.projectName!.text = "联合国新兴全球领导人和公民培养计划-测试"
            titleCell.projectContent!.text = "包含:课程,签证,机票,活动,食宿,保险 - 测试"
            titleCell.projectCity!.text = "出发城市: 北京 - 测试"
            titleCell.projectPrice!.text = "$" + "1500" + "起/人"
            
            return titleCell
            
        }
//        else if indexPath.section == 1 {
//            let dateTripCell = SX_ProjectDetailDateCell(style: .default, reuseIdentifier: projectDetailDateTripCellID)
//            dateTripCell.selectionStyle = .none
//            dateTripCell.accessoryType  = .none
//
//            dateTripCell.moreDateBtn?.rx.tap.subscribe(onNext: { (_) in
//
//                SXLog("进入更多日期界面++++++, 坑啊, 填不完了.......|| _ ||")
//
//            }, onError: { (error) in
//                SXLog(error)
//            }, onCompleted: nil, onDisposed: nil)
//
//            return dateTripCell
//        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: projectDetailCellID)
        
        // cell.addSubview(self.subView)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 135.FloatValue.IPAD_XValue
            
        case 1:
            return 185.FloatValue.IPAD_XValue
            
        default:
            return 50.FloatValue.IPAD_XValue
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0.01
        } else if section == 2 {
            return 50.FloatValue.IPAD_XValue
        }
        
        return Margin-5
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

// ============================================================================================================================
// MARK: - SXCycleScrollerViewDelegate
// ============================================================================================================================
extension SX_ProjectDetailController: SXCycleScrollerViewDelegate {
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        SXLog("点击了实训项目详情轮播的\(index)")
    }
}

// ============================================================================================================================
// MARK: - UIScrollViewDelegate
// ============================================================================================================================
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


