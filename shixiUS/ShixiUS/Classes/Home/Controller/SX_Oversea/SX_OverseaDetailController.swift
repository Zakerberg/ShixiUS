//
//  SX_OverseaDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/23/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业详情界面

import UIKit

private let ArrowTag = 3000
private let ControlTag = 1000
private let LabelTag = 2000

let overseaCellID = "overseaCellID"

class SX_OverseaDetailController: UIViewController {
    
// =========================================================================================================================
//  MARK: - lazy
// =========================================================================================================================
    /// 职位分类View
    private lazy var positionView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 440)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["不限","会计服务","航空","银行","电子商务","互联网","表演艺术","翻译和本地化","医疗","服装和时装","测试12"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作性质View
    private lazy var workNatureView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作时常View
    private lazy var workTimeView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["1","2","3"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 发布日期View
    private lazy var releaseDateView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["4","5","666"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    private lazy var overseaTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 35, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    var topSelectedView: SX_TopSelectedView?
    var blackBgView: UIView? // 黑色背景弹窗
    
// ===================================================================================================================
// MARK: - O
// ===================================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        overseaTableView.delegate = nil
        print("overseaTableView ---deinit")
   }
}

// ===========================================================================================================================
// MARK: - Other Method
// ===========================================================================================================================
extension SX_OverseaDetailController {
    
    func setUI() {
        self.title = "海外就业"
        self.view.backgroundColor = UIColor.white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.positionView.isHidden    = true
        self.workTimeView.isHidden    = true
        self.workNatureView.isHidden  = true
        self.releaseDateView.isHidden = true
        
        self.view.insertSubview(self.overseaTableView, belowSubview: self.positionView)
        
        setTopSelectedView()
    }
    
    /// .....
    func fetchData() {
        
        
    }
    
    /// 顶部4个按钮
    func setTopSelectedView() {
        
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (topSelectedView) in
            topSelectedView.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (lineView) in
            lineView.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        var titleArr = ["职位分类","工作性质","工作时长","发布日期"]
        for index in 0..<4 {
            let view = creatBtnView(titleArr[index], frame: CGRect(x: Int((SCREEN_WIDTH/4)) * index, y: 0, width: Int(SCREEN_WIDTH/4), height: 44), tag: index)
            view.isUserInteractionEnabled = true
            self.topSelectedView?.addSubview(view)
            
            let control = UIControl(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            control.addTarget(self, action: #selector(topSelectedBtnClick), for: .touchUpInside)
            control.tag = index + ControlTag
            
            view.addSubview(control)
        }
    }
    
    /// 创建头部选择条件View
    func creatBtnView(_ title:String, frame: CGRect, tag:NSInteger) -> UIView {
        
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.groupTableViewBackground
        
        let label = UILabel().addhere(toSuperView: view).layout { (make) in
            make.centerX.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 65, height: 14))
            }.config { (label) in
                label.text = title
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor.black
                label.textAlignment = .right
                label.tag = tag + LabelTag
        }
        
        let _ = UIImageView(image: UIImage.init(named: "btn_down")).addhere(toSuperView: view).layout { (make) in
            make.left.equalTo(label.snp.right).offset(5)
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 7, height: 4))
            }.config { (imageV) in
                imageV.tag = tag + ArrowTag
        }
        return view
    }
}

// ==========================================================================================================================
// MARK: - Other Method 2 响应
// =============================================================================================================================
extension SX_OverseaDetailController {
    /// 调出PickerView
    @objc func topSelectedBtnClick(control: UIControl) {
        if control.isSelected == true {
            control.isSelected = false
            /// 收起
            hideViewWithAnimation(view: self.positionView)
            hideViewWithAnimation(view: self.workNatureView)
            hideViewWithAnimation(view: self.workTimeView)
            hideViewWithAnimation(view: self.releaseDateView)
            
        }else if(control.isSelected == false) {
            control.isSelected = true
            
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
        
        self.blackBgView?.isHidden = true
        if view.isHidden == false {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                view.frame = CGRect(x: 0, y: -view.bounds.size.width, width: SCREEN_WIDTH, height: view.bounds.size.height)
            }) {(finished) in
                view.isHidden = true
            }
            UIView.animate(withDuration: 0.4, animations: {
                /// 小三角的选中状态
                for index in 0..<4 {
                    
                    let allImg = self.topSelectedView?.viewWithTag(ArrowTag + index) as? UIImageView
                    allImg?.image = UIImage.init(named: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(-Double.pi)*0)
                    allImg?.transform = transform
                    
                    let allLabel = self.topSelectedView?.viewWithTag(LabelTag + index) as? UILabel
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
            
            self.workNatureView.frame = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
            self.workTimeView.frame = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
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
            
            self.positionView.frame = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workTimeView.frame = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
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
            
            self.positionView.frame = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workNatureView.frame = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
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
            
            self.positionView.frame = CGRect(x: 0, y: -self.positionView.bounds.size.height, width: SCREEN_WIDTH, height: self.positionView.bounds.size.height)
            self.workNatureView.frame = CGRect(x: 0, y: -self.workNatureView.bounds.size.height, width: SCREEN_WIDTH, height: self.workNatureView.bounds.size.height)
            self.workTimeView.frame = CGRect(x: 0, y: -self.workTimeView.bounds.size.height, width: SCREEN_WIDTH, height: self.workTimeView.bounds.size.height)
            
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
        
        self.blackBgView?.isHidden = false
        view.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: self.topSelectedView!.bounds.origin.y + self.topSelectedView!.bounds.size.height + 0.5, width: SCREEN_WIDTH, height: view.bounds.size.height)
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 翻转箭头
        UIView.animate(withDuration: 0.1, animations: {
            let selectedImg = self.topSelectedView?.viewWithTag(tag-ControlTag+ArrowTag) as! UIImageView
            selectedImg.image = UIImage.init(named: "btn_odown")
            let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            selectedImg.transform = transform
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 恢复状态
        for index in 0..<4 {
            if (index != (tag-ControlTag)) {
                UIView.animate(withDuration: 0.1, animations: {
                    let allImg = self.topSelectedView?.viewWithTag(index+ArrowTag) as? UIImageView
                    allImg?.image = UIImage.init(named: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi)*0)
                    allImg?.transform = transform
                }) { (finished) in
                    SXLog(finished)
                    let allLabel = self.topSelectedView?.viewWithTag(index+LabelTag) as? UILabel
                    allLabel?.textColor = UIColor.black
                }
            }
            
            let selectedLabel = self.topSelectedView?.viewWithTag(tag-ControlTag+LabelTag) as? UILabel
            selectedLabel?.textColor = UIColor.SX_MainColor()
        }
    }
}

// ==============================================================================================================================
// MARK: - UITableViewDelegate
// =============================================================================================================================
extension SX_OverseaDetailController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SX_OverseaCell(style: .default, reuseIdentifier: overseaCellID)
        cell.jobName?.text = "[金融] 美国金融岗位美国金融岗位美国金融岗位"
        cell.address?.text = "美国/New York"
        cell.nature?.text = "全职1"
        cell.duration?.text = "实习2"
        cell.date?.text = "2018.18.18"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SXLog("点击了海外就业的第\(indexPath.row)个")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


