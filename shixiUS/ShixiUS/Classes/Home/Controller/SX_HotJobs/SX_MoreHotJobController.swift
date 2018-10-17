//
//  SX_MoreHotJobController.swift
//  ShixiUS
//
//  Created by heather on 2018/9/10.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  热门岗位的更多 && 海外就业

/*
 风吹乱你的秀发
 刚刚好
 吹动了我的心
 */

import UIKit
import SwiftyJSON

private let ArrowTag   = 3000
private let ControlTag = 1000
private let LabelTag   = 2000
let hotJobCellID       = "hotJobCellID"

class SX_MoreHotJobController: UIViewController {
    
    var tableView: UITableView?
    var jobListsMlodel = [JobListModel]()
    
    /////用于Search搜索////
    var typeStr:     String = "0"
    var natureStr:   String = "0"
    var durationStr: String = "0"
    var settrStr:    String = "0"
    /////////////////////
    var baseURL             = ""
    
    /// 职位分类View
    lazy var positionView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 440)).addhere(toSuperView: self.view).config({ (POSITIONVIEW) in
            POSITIONVIEW.backgroundColor   = UIColor.white
            POSITIONVIEW.dataArr           = ["不限","会计服务","航空","银行","电子商务","互联网","表演艺术","翻译和本地化","医疗","服装和时装","测试12"]
            POSITIONVIEW.isHidden          = true
        })
        return positionView
    }()
    
    /// 工作性质View
    lazy var workNatureView: UIView = {
        let natureView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (WORKNATUREVIEW) in
            WORKNATUREVIEW.backgroundColor = UIColor.white
            WORKNATUREVIEW.dataArr         = ["中国","美国","不限"]
            WORKNATUREVIEW.isHidden        = true
        })
        return natureView
    }()
    
    /// 工作时常View
    lazy var workTimeView: UIView = {
        let timeView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (WORKTIMEVIEW) in
            WORKTIMEVIEW.backgroundColor   = UIColor.white
            WORKTIMEVIEW.isHidden          = true
            WORKTIMEVIEW.dataArr           = ["1","2","3"]
        })
        return timeView
    }()
    
    /// 发布日期View
    lazy var releaseDateView: UIView = {
        let releaseView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (RELEASEDATEView) in
            RELEASEDATEView.backgroundColor = UIColor.white
            RELEASEDATEView.dataArr         = ["4","5","666"]
            RELEASEDATEView.isHidden        = true
        })
        return releaseView
    }()
    
    var topSelectedView: SX_TopSelectedView?
    //    var blackBgView: UIView? // 黑色背景弹窗
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Noti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        //fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        //        tableView!.delegate = nil
        print("overseaTableView ---deinit")
    }
}

// =================================================================================================================
// MARK: - Other Method
// =================================================================================================================
extension SX_MoreHotJobController {
    
    func setUI() {
        title                         = "热门岗位"
        view.backgroundColor          = UIColor.white
        
        setTopSelectedView()
    }
    
    /// 顶部4个按钮
    func setTopSelectedView() {
        
        //        self.tableView = UITableView(frame: CGRect.zero, style: .plain)
        //        self.tableView?.backgroundColor                = UIColor.white
        //        self.tableView?.delegate                       = self
        //        self.tableView?.dataSource                     = self
        //        self.tableView?.showsVerticalScrollIndicator   = false
        //        self.tableView?.showsHorizontalScrollIndicator = false
        //        self.view.insertSubview(self.tableView!, belowSubview: self.workNatureView)
        //
        //        self.tableView?.snp.makeConstraints({ (make) in
        //            make.top.equalToSuperview().offset(kNavH+60.FloatValue.IPAD_XValue)
        //            make.width.equalToSuperview()
        //            make.bottom.equalToSuperview()
        //        })
        
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (TOPSELECTEDVIEW) in
            TOPSELECTEDVIEW.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (LINEVIEW) in
            LINEVIEW.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        var titleArr = ["职位分类","工作性质","工作时长","发布日期"]
        for index in 0..<4 {
            let view = creatBtnView(titleArr[index], frame: CGRect(x: Int((SCREEN_WIDTH/4)) * index, y: Int(kNavH), width: Int(SCREEN_WIDTH/4), height: 44), tag: index)
            view.isUserInteractionEnabled = true
            self.topSelectedView?.addSubview(view)
            
            let Control = UIControl(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            Control.addTarget(self, action: #selector(topSelected), for: .touchUpInside)
            Control.tag = index + ControlTag
            view.addSubview(Control)
        }
    }
    
    /// 创建头部选择条件View
    func creatBtnView(_ title:String, frame: CGRect, tag:NSInteger) -> UIView {
        
        let view             = UIView(frame: frame)
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel().addhere(toSuperView: view).layout { (make) in
            make.centerX.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 65, height: 14))
            }.config { (label) in
                label.text          = title
                label.font          = UIFont.systemFont(ofSize: 14)
                label.textColor     = UIColor.black
                label.textAlignment = .right
                label.tag           = tag + LabelTag
        }
        
        let _ = UIImageView(image: #imageLiteral(resourceName: "btn_down")).addhere(toSuperView: view).layout { (make) in
            make.left.equalTo(label.snp.right).offset(5)
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 7, height: 4))
            }.config { (imageV) in
                imageV.tag = tag + ArrowTag
        }
        return view
    }
}

// =========================================================================================
// MARK: - Other Method 2
// =========================================================================================
extension SX_MoreHotJobController {
    
    //        func fetchData() {
    //            baseURL = SHIXIUS + "/job/index"
    //            SX_NetManager.requestData(type: .GET, URlString: baseURL, parameters: nil) { (result) in
    //                do{
    //                    let json = try JSON(data: result)
    //                    /// 成功
    //                    SXLog("成功! ")
    //                    for item in json["data"]["lists"].array ?? [] {
    //                        let Model = JobListModel(jsonData: item)
    //                        self.jobListsMlodel.append(Model)
    //                    }
    //                    self.tableView!.reloadData()
    //                } catch{ }
    //            }
    //        }
    
    /// 调出PickerView
    @objc func topSelected(control: UIControl) {
        if control.isSelected == true {
            control.isSelected = false
            /// 收起
            hideViewWithAnimation(view: self.positionView)
            hideViewWithAnimation(view: self.workNatureView)
            hideViewWithAnimation(view: self.workTimeView)
            hideViewWithAnimation(view: self.releaseDateView)
            
        }else if(control.isSelected == false) {
            control.isSelected      = true
            
            /// 创建弹窗 选择条件
            if(control.tag == 1000) {
                showViewWithAnimationAndTag(self.positionView, tag: control.tag)
                hideViewWithAnimation(view: self.workNatureView)
                hideViewWithAnimation(view: self.workTimeView)
                hideViewWithAnimation(view: self.releaseDateView)
                
            } else if(control.tag == 1001) {
                showViewWithAnimationAndTag(self.workNatureView, tag: control.tag)
                hideViewWithAnimation(view: self.positionView)
                hideViewWithAnimation(view: self.workTimeView)
                hideViewWithAnimation(view: self.releaseDateView)
                
            } else if(control.tag == 1002) {
                showViewWithAnimationAndTag(self.workTimeView, tag: control.tag)
                hideViewWithAnimation(view: self.positionView)
                hideViewWithAnimation(view: self.workNatureView)
                hideViewWithAnimation(view: self.releaseDateView)
                
            } else if(control.tag == 1003) {
                showViewWithAnimationAndTag(self.releaseDateView, tag: control.tag)
                hideViewWithAnimation(view: self.positionView)
                hideViewWithAnimation(view: self.workNatureView)
                hideViewWithAnimation(view: self.workTimeView)
            }
        }
    }
    
    /// hideView
    func hideViewWithAnimation(view: UIView) {
        //        self.blackBgView?.isHidden = true
        if view.isHidden == false {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                view.frame    = CGRect(x: 0, y: -view.bounds.size.width, width: SCREEN_WIDTH, height: view.bounds.size.height)
            }) {(finished) in
                view.isHidden = true
            }
            
            UIView.animate(withDuration: 0.4, animations: {
                /// 小三角的选中状态
                for index in 0..<4 {
                    
                    let allImg = self.topSelectedView?.viewWithTag(ArrowTag + index) as? UIImageView
                    allImg?.image = #imageLiteral(resourceName: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(-Double.pi)*0)
                    allImg?.transform   = transform
                    
                    let allLabel        = self.topSelectedView?.viewWithTag(LabelTag + index) as? UILabel
                    allLabel?.textColor = UIColor.black
                }
            }) { (finished) in
                SXLog(finished)
            }
        }
    }
    /// 展示隐藏动画
    func showViewWithAnimationAndTag(_ view: UIView, tag: NSInteger) {
        if view.isKind(of: type(of: self.positionView)) { //职位分类
            self.workNatureView.frame  = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
            self.workTimeView.frame    = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
            self.releaseDateView.frame = CGRect(x: 0, y: -self.releaseDateView.bounds.size.height, width: SCREEN_WIDTH, height: self.releaseDateView.bounds.size.height)
            
            self.workNatureView.isHidden  = true
            self.workTimeView.isHidden    = true
            self.releaseDateView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            let control3 = self.topSelectedView?.viewWithTag(1003) as? UIControl
            control3?.isSelected = false
            
        } else if(view.isKind(of: type(of: workNatureView))) {  // 工作性质
            
            self.positionView.frame    = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workTimeView.frame    = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
            self.releaseDateView.frame = CGRect(x: 0, y: -self.releaseDateView.bounds.size.height, width: SCREEN_WIDTH, height: self.releaseDateView.bounds.size.height)
            
            self.positionView.isHidden    = true
            self.workTimeView.isHidden    = true
            self.releaseDateView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            let control3 = self.topSelectedView?.viewWithTag(1003) as? UIControl
            control3?.isSelected = false
            
        } else if(view.isKind(of: type(of: self.workTimeView))) { // 工作时长
            
            self.positionView.frame    = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workNatureView.frame  = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
            self.releaseDateView.frame = CGRect(x: 0, y: -self.releaseDateView.bounds.size.height, width: SCREEN_WIDTH, height: self.releaseDateView.bounds.size.height)
            
            self.positionView.isHidden    = true
            self.workNatureView.isHidden  = true
            self.releaseDateView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected = false
            let control3 = self.topSelectedView?.viewWithTag(1003) as? UIControl
            control3?.isSelected = false
            
        } else if(view.isKind(of: type(of: self.releaseDateView))) { // 发布日期
            
            self.positionView.frame   = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workNatureView.frame = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
            self.workTimeView.frame   = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
            
            self.positionView.isHidden   = true
            self.workNatureView.isHidden = true
            self.workTimeView.isHidden   = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected = false
            let control3 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control3?.isSelected = false
        }
        
        //        self.blackBgView?.isHidden = false
        view.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: self.topSelectedView!.bounds.origin.y + self.topSelectedView!.bounds.size.height + 0.5, width: SCREEN_WIDTH, height: view.bounds.size.height)
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 翻转箭头
        UIView.animate(withDuration: 0.1, animations: {
            let selectedImg       = self.topSelectedView?.viewWithTag(tag-ControlTag+ArrowTag) as! UIImageView
            selectedImg.image     = #imageLiteral(resourceName: "btn_odown")
            let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            selectedImg.transform = transform
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 恢复状态
        for index in 0..<4 {
            if (index != (tag-ControlTag)) {
                UIView.animate(withDuration: 0.1, animations: {
                    let allImg          = self.topSelectedView?.viewWithTag(index+ArrowTag) as? UIImageView
                    allImg?.image       = #imageLiteral(resourceName: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi)*0)
                    allImg?.transform   = transform
                }) { (finished) in
                    SXLog(finished)
                    let allLabel        = self.topSelectedView?.viewWithTag(index+LabelTag) as? UILabel
                    allLabel?.textColor = UIColor.black
                }
            }
            
            let selectedLabel           = self.topSelectedView?.viewWithTag(tag-ControlTag+LabelTag) as? UILabel
            selectedLabel?.textColor    = UIColor.SX_MainColor()
        }
    }
    
    
    
}

// ===============================================================
// MARK: - UITableViewDelegate
// ===============================================================
//extension SX_MoreHotJobController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.jobListsMlodel.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = SX_OverseaCell(style: .default, reuseIdentifier: hotJobCellID)
//        cell.selectionStyle = .none
//        let model = jobListsMlodel[indexPath.row]
//
//        cell.jobName?.text  = model.title ?? "测试名字"
//        cell.address?.text  = model.address ?? "测试地址"
//        cell.nature?.text   = model.nature ?? "测试"
//        cell.date?.text     = model.time ?? "测试时间"
//        cell.duration?.text = model.duration ?? "测试"
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 70
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        SXLog("点击了海外就业的第\(indexPath.row)个")
//
//    }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//}

// ===============================================================
// MARK: - Noti
// ===============================================================
extension SX_MoreHotJobController {
    func Noti() {
        
    }
}

// ===============================================================
// MARK: - SCROLL
// ===============================================================
extension SX_MoreHotJobController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideViewWithAnimation(view: self.positionView)
        hideViewWithAnimation(view: self.workNatureView)
        hideViewWithAnimation(view: self.workTimeView)
        hideViewWithAnimation(view: self.releaseDateView)
    }
}



