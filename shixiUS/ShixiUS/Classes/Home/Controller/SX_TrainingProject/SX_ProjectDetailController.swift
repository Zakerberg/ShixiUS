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
import SwiftyJSON
import MBProgressHUD

let projectDetailTitleCellID    = "projectDetailTitleCellID"
let projectDetailDateTripCellID = "projectDetailDateTripCellID"

let projectDetailCellID         = "projectDetailCellID"

class SX_ProjectDetailController: SX_BaseController {
    
    var topArr = ["项目亮点", "日程安排", "费用说明", "预定须知"]
    var id:String?
    var serverImgs       = [String]()
    var projectDetailArr = JSON()
    var moreDateBtn: UIButton?
    var sectionTitle: UILabel?
    
    /// 行程标题
    var tripTitleArr = [String]()
    /// 日期
    var tripDateArr  = [String]()
    /// 价格
    var tripPriceArr = [String]()
    
    /// 日程安排
    var schedule     = [TrainingDetailScheduleModel]()
    /// 是否收藏
    var collection: String?
    
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
        table.contentInset   = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavH), 0, 0, 0);
        table.delegate       = self
        table.dataSource     = self
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    /// 项目详情的轮播
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
        showLoadingView()
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

// ===============================================================================
// MARK: - Other Method
// ===============================================================================
extension SX_ProjectDetailController {
    
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
                
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    if self.collectionBtn?.isSelected == true {
                        SXLog("已收藏,点击取消收藏")
                        let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode       = .text
                        hud.isSquare   = true
                        hud.label.text = "已取消收藏"
                        hud.hide(animated: true, afterDelay: 1.0)
                        self.collectionBtn?.isSelected = false
                    }else {
                        SXLog("未收藏,点击收藏职位")
                        let hud        = MBProgressHUD.showAdded(to: self.view, animated: true)
                        hud.mode       = .text
                        hud.isSquare   = true
                        hud.label.text = "已收藏"
                        hud.hide(animated: true, afterDelay: 1.0)
                        self.collectionBtn?.isSelected = true
                    }
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
            APPLY.setTitle("立即申请", for: .normal)
            APPLY.rx.tap.subscribe(onNext: { (_) in
                SXLog("立即申请 +++ + ")
                
                if String(describing: USERDEFAULTS.value(forKey: "login")!) == "no" {
                    let vc = SX_LoginController()
                    self.present(vc, animated: true, completion: nil)
                }else{
                    let vc =  SX_ApplyTrainListController()
                    
                    
                    

                    
                    
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil)
        })        
    }
    
    func fetchData() {
        
        SX_NetManager.requestData(type: .GET, URlString: (SX_TrainingDetail + self.id!), parameters:  nil, finishCallBack: { (result) in
            do{
                /// SwiftyJSON 在这里 ! ! !
                let json = try JSON(data: result)
                self.serverImgs.append(json["data"]["image"].string!)
                self.detailScrollerView.serverImgArray = self.serverImgs
                self.projectDetailArr = JSON(arrayLiteral: json.dictionary ?? [:])
                
                for item in json["data"]["training"].array ?? [] {
                    self.tripTitleArr.append(item["title"].string ?? "")
                }
                for item in json["data"]["details"].array ?? [] {
                    self.tripDateArr.append(item["date"].string ?? "")
                    self.tripPriceArr.append(item["price"].string ?? "")
                }
                self.hideLoadingView()
                self.detailScrollerView.reloadData()
                self.tableView.reloadData()
            } catch{ }
        })
    }
}

// ===============================================================================
// MARK: - UITableViewDelegate
// ===============================================================================
extension SX_ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model     = self.projectDetailArr[indexPath.section]
        if indexPath.section == 0 {
            let titleCell = SX_ProjectDetailTitleCell(style: .default, reuseIdentifier: projectDetailTitleCellID)
            titleCell.selectionStyle     = .none
            titleCell.projectName?.text  = model["data"]["title"].string ?? ""
            titleCell.projectCity?.text  = "出发城市: " + (model["data"]["outset_city"].string ?? "北京(测试)")
            titleCell.projectPrice?.text = "¥" + "100" + "起/人"
            
            return titleCell
            
        }else if indexPath.section == 1 {
            let cell = SX_ProjectTripDateCell(style: .default, reuseIdentifier: "TRIPDATACELL")
            cell.selectionStyle = .none
            cell.tripArr        = self.tripTitleArr
            cell.dateArr        = self.tripDateArr
            cell.priceArr       = self.tripPriceArr
            
            self.moreDateBtn    = cell.moreDate
            self.moreDateBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("更多日期 ")
                
                let vc = SX_MoreDateController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil).dispose()
            
            return cell
            
        } else if indexPath.section == 2 {
            let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: projectDetailCellID)
            cell.selectionStyle            = .none
            cell.titleLabel?.text          = "项目亮点"
            cell.titleLabel?.textAlignment = .center
            
            cell.contentLabel?.text        = model["data"]["features"].string ?? "1112243343256(测试项目亮点数据)"
            
            return cell
        } else if indexPath.section == 3 { // 日程安排
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cellsection3")
            cell.selectionStyle  = .none
            cell.textLabel?.text = "3333333^^^^^^^^"
            
            return cell
        } else if indexPath.section == 4 || indexPath.section == 5 {
            let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: projectDetailCellID)
            cell.selectionStyle = .none
            cell.titleLabel?.textAlignment = .center
            
            if indexPath.section == 4 {
                cell.titleLabel?.text  = "费用说明"
                cell.contentLabel?.text = model["data"]["expense"].string ?? "3233333332332323(测试费用说明数据)"
            }else {
                cell.titleLabel?.text  = "预定须知"
                cell.contentLabel?.text = model["data"]["destine"].string ?? "098634566787096789889(测试预定须知数据)"
            }
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model     = self.projectDetailArr[indexPath.section]
        switch indexPath.section {
        case 0:
            return 110.FloatValue.IPAD_XValue
        case 1:
            return 190.FloatValue.IPAD_XValue
        case 2:
            return UILabel.SX_getSpaceLabelHeight((model["data"]["features"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
        case 3:
            return UILabel.SX_getSpaceLabelHeight((model["data"]["features"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
        case 4:
            return UILabel.SX_getSpaceLabelHeight((model["data"]["expense"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
        case 5:
            return UILabel.SX_getSpaceLabelHeight((model["data"]["destine"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 14), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 60.FloatValue.IPAD_XValue
        default:
            return 200.FloatValue.IPAD_XValue
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.FloatValue.IPAD_XValue
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if  section == 2 {
            return 40.FloatValue.IPAD_XValue
        }
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            let view = self.pageTitleView
            tableView.tableHeaderView?.addSubview(view)
            return view
        }else if section == 3 {
            let view = UIView()
            view.backgroundColor = UIColor.white
            self.sectionTitle = UILabel().addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.left.top.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(17)
            }).config({ (TITLE) in
                TITLE.sizeToFit()
                TITLE.textAlignment = .center
                TITLE.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                TITLE.font          = UIFont.boldSystemFont(ofSize: 16)
            })
            
            _ = UIView().addhere(toSuperView: view).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.sectionTitle!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.height.equalTo(0.5)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (LINE) in
                LINE.backgroundColor = UIColor.SX_LineColor()
            })
            return view
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

// ===============================================================================
// MARK: - SXCycleScrollerViewDelegate
// ===============================================================================
extension SX_ProjectDetailController: SXCycleScrollerViewDelegate {
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        SXLog("点击了实训项目详情轮播的\(index)")
    }
}

// ===============================================================================
// MARK: - UIScrollViewDelegate
// ===============================================================================
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
                } else {
                    weakSelf.navBarBackgroundAlpha = 1.0
                }
            }
        })
    }
}

// ===============================================================================
// MARK: -  SXPageTitleViewDelegate
// ===============================================================================
extension SX_ProjectDetailController: SXPageTitleViewDelegate {
    
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        SXLog(selectedIndex)
        if self.topArr.count > 0 {
            if selectedIndex == 0 {
                //  self.tableView.scrollToRow(at: IndexPath(row: 0, section: 2), at: .top, animated: true)
            } else if selectedIndex == 1 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 3), at: .top, animated: true)
            } else if selectedIndex == 2 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 4), at: .top, animated: true)
            } else if selectedIndex == 3 {
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 5), at: .top, animated: true)
            }
        }
    }
}
