//
//  SX_CertificationDetailController.swift
//  ShixiUS
//
//  Created by heather on 2018/10/19.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证详情

/*
 思念所达之地
 目光所及之处
 都是你
 */

import UIKit
import SwiftyJSON
import MBProgressHUD

class SX_CertificationDetailController: SX_BaseController {
    var topArr = ["课程介绍", "课程大纲", "名师介绍"]
    
    var id: String?
    var moreDateBtn: UIButton?
    var serverImgs = [String]()
    var sectionTitle: UILabel?
    var certificationDetailArr = JSON()
    
    /// 课程标题
    var classTitleArr  = [String]()
    /// 课程日期
    var classDateArr   = [String]()
    /// 课程价格
    var classPriceArr  = [String]()
    
    /// 课程目标
    var target: UILabel?
    /// 主要受众
    var audience: UILabel?
    /// 主要内容
    var content: UILabel?
    
    //// 课程大纲
    var curriculumListArr = [TrainDetailCurriculumModel]()
    
    /// teacher 列表
    var teacherListArr    = [TrainDetailTeacherModel]()
    
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
                
                self.serverImgs.append(json["data"]["image"].string!)
                self.detailScrollerView.serverImgArray = self.serverImgs
                self.certificationDetailArr = JSON(arrayLiteral: json.dictionary ?? [:])
                
                for item in json["data"]["series"].array ?? [] {
                    self.classTitleArr.append(item["name"].string ?? "")
                }
                for item in json["data"]["courseprice"].array ?? [] {
                    self.classDateArr.append(item["date"].string ?? "")
                    self.classPriceArr.append(item["price"].string ?? "")
                }
                for item in json["data"]["curriculum"].array ?? [] {
                    let curriculumModel = TrainDetailCurriculumModel(jsonData: item)
                    self.curriculumListArr.append(curriculumModel)
                }
                for item in json["data"]["teacher"].array ?? [] {
                    let teacherModel = TrainDetailTeacherModel(jsonData: item)
                    self.teacherListArr.append(teacherModel)
                }
                
                self.hideLoadingView()
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 4 {
            return self.curriculumListArr.count
        }else if section == 5 {
            return self.teacherListArr.count
        }else{
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let model = self.certificationDetailArr[indexPath.row]
            let titleCell = SX_ProjectDetailTitleCell(style: .default, reuseIdentifier: projectDetailTitleCellID)
            titleCell.selectionStyle = .none
            
            titleCell.projectName?.text    = model["data"]["title"].string ?? ""
            titleCell.projectContent?.text = "主讲老师: " + (model["data"]["teacher_name"].string ?? "")
            titleCell.projectCity?.text    = "授课地点: " + (model["data"]["address"].string ?? "")
            
            titleCell.projectPrice?.text   = "¥" + ("1500") + "起/人"
            
            return titleCell
            
        }else if indexPath.section == 1 {
            let model = self.certificationDetailArr[indexPath.row]
            let cell = SX_ProjectTripDateCell(style: .default, reuseIdentifier: "TRIPDATACELL")
            cell.selectionStyle = .none
            cell.tripArr        = self.classTitleArr
            cell.dateArr        = self.classDateArr
            cell.priceArr       = self.classPriceArr
            
            self.moreDateBtn    = cell.moreDate
            self.moreDateBtn?.rx.tap.subscribe(onNext: { (_) in
                SXLog("更多日期 ")
                
                let vc = SX_MoreDateController()
                self.navigationController?.pushViewController(vc, animated: true)
                
            }, onError: { (error) in
                SXLog(error)
            }, onCompleted: nil, onDisposed: nil).dispose()
            
            return cell
        }else if indexPath.section == 2 {
            let model = self.certificationDetailArr[indexPath.row]
            let cell = UITableViewCell(style: .default, reuseIdentifier: "parameterCellID")
            cell.selectionStyle = .none
            
            let title = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalToSuperview().offset(10.FloatValue.IPAD_XValue)
                make.centerX.equalToSuperview()
                make.width.equalToSuperview()
            }).config({ (TITLE) in
                TITLE.textAlignment    = .center
                TITLE.text             = "课程参数"
                TITLE.textColor        = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                TITLE.font             = UIFont.boldSystemFont(ofSize: 15)
            })
            
            let _ = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(15)
            }).config({ (TARL) in
                TARL.text              = "课程目标: "
                TARL.textColor         = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                TARL.font              = UIFont.boldSystemFont(ofSize: 14)
            })
            
            self.target = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(title.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (TARGET) in
                TARGET.numberOfLines   = 0
                TARGET.text            = "                  " + (model["data"]["target"].string ?? "")
                TARGET.textColor       = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
                TARGET.font            = UIFont.systemFont(ofSize: 15)
            })
            
            let audL = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.target!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (AUDL) in
                AUDL.text              = "主要受众: "
                AUDL.textColor         = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                AUDL.font              = UIFont.boldSystemFont(ofSize: 14)
            })
            
            self.audience = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(self.target!.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (AUDIENCE) in
                AUDIENCE.numberOfLines = 0
                AUDIENCE.text          = "                  " + (model["data"]["audience"].string ?? "")
                AUDIENCE.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
                AUDIENCE.font          = UIFont.systemFont(ofSize: 15)
            })
            
            let _ = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(audL.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (AUDIENCE) in
                AUDIENCE.text          = "主要内容: "
                AUDIENCE.textColor     = UIColor.colorWithRGB(r: 51, g: 51, b: 51)
                AUDIENCE.font          = UIFont.boldSystemFont(ofSize: 15)
            })
            
            self.content = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(audL.snp.bottom).offset(10.FloatValue.IPAD_XValue)
                make.left.equalToSuperview().offset(Margin)
                make.right.equalToSuperview().offset(-Margin)
            }).config({ (CONTENT) in
                CONTENT.numberOfLines = 0
                CONTENT.text          = "                  " + (model["data"]["content"].string ?? "")
                CONTENT.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
                CONTENT.font          = UIFont.systemFont(ofSize: 15)
            })
            
            return cell
        } else if indexPath.section == 3 {
            let model = self.certificationDetailArr[indexPath.row]
            let cell = SX_HotJobContentDetailCell(style: .default, reuseIdentifier: projectDetailCellID)
            cell.selectionStyle = .none
            
            cell.titleLabel?.text   = "课程介绍"
            cell.contentLabel?.text = model["data"]["describe"].string ?? ""
            
            return cell
        } else if indexPath.section == 4 {
            let cell  = UITableViewCell(style: .default, reuseIdentifier: "curriculumCellID")
            let model = self.curriculumListArr[indexPath.row]
            cell.selectionStyle = .none
            self.sectionTitle?.text = "课程大纲"
            let circleImage = UIImageView(image: #imageLiteral(resourceName: "icon_CertificationDetail_circle")).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.left.equalToSuperview().offset(20.FloatValue.IPAD_XValue)
                make.width.height.equalTo(20.FloatValue.IPAD_XValue)
            }).config({ (CIRCLE) in
                
            })
            
            let titleImageV = UIImageView(image: #imageLiteral(resourceName: "icon_CertificationDetail_ClassTitle")).addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.centerY.equalTo(circleImage)
                make.left.equalTo(circleImage.snp.right).offset(8.FloatValue.IPAD_XValue)
                make.right.equalToSuperview().offset(-Margin)
                make.height.equalTo(25.FloatValue.IPAD_XValue)
            }).config({ (TITLEV) in
                
            })
            
            let classTitle = UILabel().addhere(toSuperView: titleImageV).layout(snapKitMaker: { (make) in
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(Margin)
                make.height.equalTo(14)
            }).config({ (CLASSTITLE) in
                CLASSTITLE.sizeToFit()
                CLASSTITLE.text            = model.title ?? ""
                CLASSTITLE.textColor       = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
                CLASSTITLE.font            = UIFont.systemFont(ofSize: 13)
            })
            
            _ = UILabel().addhere(toSuperView: cell.contentView).layout(snapKitMaker: { (make) in
                make.top.equalTo(titleImageV.snp.bottom).offset(Margin)
                make.left.equalTo(classTitle)
                make.right.equalTo(titleImageV)
            }).config({ (CLASSCONTENT) in
                CLASSCONTENT.sizeToFit()
                CLASSCONTENT.numberOfLines = 0
                CLASSCONTENT.text          = model.content ?? ""
                CLASSCONTENT.textColor     = UIColor.colorWithRGB(r: 102, g: 102, b: 102)
                CLASSCONTENT.font          = UIFont.systemFont(ofSize: 15)
            })
            
            return cell
        } else if indexPath.section == 5 {
            let cell  = SX_TrainDetailTeacherCell(style: .default, reuseIdentifier: "teachercellID")
            cell.selectionStyle     = .none
            self.sectionTitle?.text = "名师介绍"
            let model               = self.teacherListArr[indexPath.row]
            if let url = URL(string: model.image ?? "") {
                cell.icon?.kf.setImage(with: url)
            }else {
                cell.icon?.image = #imageLiteral(resourceName: "icon_placeholdericon_Image")
            }
            cell.name?.text         = model.name ?? "张亮(测试)"
            cell.info?.text         = (model.school! + ",") + (model.title! + ",") + (model.company!)
            cell.describe?.text     = model.describe ?? "张亮简介(测试)"
            
            return cell
        }
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "111")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.certificationDetailArr[indexPath.row]
        
        switch indexPath.section {
        case 0: // 第四期专家中医
            return 120.FloatValue.IPAD_XValue
        case 1: // 传承弟子
            return 190.FloatValue.IPAD_XValue
        case 2: // 课程参数
            return UILabel.SX_getSpaceLabelHeight((model["data"]["target"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 15), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + UILabel.SX_getSpaceLabelHeight((model["data"]["audience"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 15), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + UILabel.SX_getSpaceLabelHeight((model["data"]["content"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 15), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 80.FloatValue.IPAD_XValue
        case 3:
            return UILabel.SX_getSpaceLabelHeight((model["data"]["describe"].string ?? "") as NSString, font: UIFont.systemFont(ofSize: 15), width: SCREEN_WIDTH-20, space: 0, zpace: 0) + 40.FloatValue.IPAD_XValue
        default:
            return 200.FloatValue.IPAD_XValue
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if  section == 2  || section == 4 || section == 5 {
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
        } else if section == 4 || section == 5 {
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
