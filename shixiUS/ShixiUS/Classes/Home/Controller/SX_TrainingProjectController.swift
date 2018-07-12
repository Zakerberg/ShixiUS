//
//  SX_TrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目

import UIKit

private let ArrowTag = 3000
private let ControlTag = 1000
private let LabelTag = 2000

class SX_TrainingProjectController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    var blackBgView: UIView? // 黑色背景弹窗
    var loadingView: SX_LoadingView?
    
//========================================================================================================================================
//  MARK: - lazy
//========================================================================================================================================
    // 综合排序View
    private lazy var comprehensiveView: UIView = {
        let compreView = SX_ComprehensiveView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 160)).addhere(toSuperView: self.view).config({ (compreView) in
            compreView.backgroundColor = UIColor.white
        })
        
        compreView.isHidden = true
        return compreView
    }()
    
    /// 实训类别View
    private lazy var trainingView: UIView = {
        let trainingView = UIView()
        
        
        
        
        
        return trainingView
    }()
    
    /// 国家分类View
    private lazy var countryView: UIView = {
        let countryView = UIView()
        
        
        
        
        
        return countryView
    }()
    
    private lazy var TableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
        setTopSelectedView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_TrainingProjectController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellID")
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "测试cell"
        return cell
    }
}

// ========================================================================================================================================
// MARK: - Other Method
// ========================================================================================================================================
extension SX_TrainingProjectController {
    
    func setUI() {
        self.title = "实训项目"
        self.view.backgroundColor = UIColor.colorWithHexString(hex: "f1f1f1", alpha: 1)
        self.trainingView.isHidden = true
        self.comprehensiveView.isHidden = true
        self.countryView.isHidden = true
    }
    
    /// 顶部三个按钮
    func setTopSelectedView() {
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (topSelectedView) in
            topSelectedView.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (lineView) in
            lineView.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        var titleArr = ["综合排序","实训项目","国家"]
        for index in 0..<3 {
            let view = creatBtnView(titleArr[index], frame: CGRect(x: Int((SCREEN_WIDTH/3)) * index, y: 0, width: Int(SCREEN_WIDTH/3), height: 44), tag: index)
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

// ========================================================================================================================================
// MARK: - Other Method 2 响应
// ========================================================================================================================================
extension SX_TrainingProjectController {
    
    func fetchData()  {
        
    }
    
    /// 调出PickerView
    @objc func topSelectedBtnClick(control: UIControl) {
        if control.isSelected == true {
            control.isSelected = false
            /// 收起
            hideViewWithAnimation(view: self.comprehensiveView)
            hideViewWithAnimation(view: self.trainingView)
            hideViewWithAnimation(view: self.countryView)
            
        }else if(control.isSelected == false) {
            control.isSelected = true
            
            /// 创建弹窗 选择条件
            if(control.tag == 1000) {
                showViewWithAnimationAndTag(self.comprehensiveView, tag: control.tag)
            } else if(control.tag == 1001) {
                showViewWithAnimationAndTag(self.trainingView, tag: control.tag)
            } else if(control.tag == 1002) {
                showViewWithAnimationAndTag(self.countryView, tag: control.tag)
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
                for index in 0..<3 {
                    
                    let allImg = self.topSelectedView?.viewWithTag(ArrowTag + index) as? UIImageView
                    allImg?.image = UIImage.init(named: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(-Double.pi)*0)
                    allImg?.transform = transform
                    
                    let allLabel = self.topSelectedView?.viewWithTag(LabelTag + index) as? UILabel
                    allLabel?.textColor = UIColor.black
                }
                
            }) { (finished) in
                
            }
        }
    }
    
    /// 展示隐藏动画
    func showViewWithAnimationAndTag(_ view: UIView, tag: NSInteger) {
        if view.isKind(of: type(of: self.comprehensiveView)) {
            
            self.trainingView.frame = CGRect(x: 0, y: -self.trainingView.bounds.size.height, width: SCREEN_WIDTH, height: self.trainingView.bounds.size.height)
            self.countryView.frame = CGRect(x: 0, y: -self.countryView.bounds.size.height, width: SCREEN_WIDTH, height: self.countryView.bounds.size.height)
            
            self.trainingView.isHidden = true
            self.countryView.isHidden  = true
            
            let control1 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: trainingView))) {
            
            self.comprehensiveView.frame = CGRect(x: 0, y: Int(-self.comprehensiveView.bounds.size.height), width: Int(SCREEN_WIDTH), height: Int(self.comprehensiveView.bounds.size.height))
            self.countryView.frame = CGRect(x: 0, y: -self.countryView.bounds.size.height, width: SCREEN_WIDTH, height: self.countryView.bounds.size.height)
            
            self.comprehensiveView.isHidden = true
            self.countryView.isHidden       = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: self.countryView))) {
            
            self.comprehensiveView.frame = CGRect(x: 0, y: -self.comprehensiveView.bounds.size.height, width: SCREEN_WIDTH, height: self.comprehensiveView.bounds.size.height)
            self.trainingView.frame = CGRect(x: 0, y: -self.trainingView.bounds.size.height, width: SCREEN_WIDTH, height: self.trainingView.bounds.size.height)
            
            self.comprehensiveView.isHidden = true
            self.countryView.isHidden       = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected = false
        }
        
        self.blackBgView?.isHidden = false
        view.isHidden = false
        
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: self.topSelectedView!.bounds.origin.y + self.topSelectedView!.bounds.size.height + 0.5, width: SCREEN_WIDTH, height: view.bounds.size.height)
        }) { (finished) in
            
        }
        
        /// 翻转箭头
        UIView.animate(withDuration: 0.1, animations: {
            let selectedImg = self.topSelectedView?.viewWithTag(tag-ControlTag+ArrowTag) as! UIImageView
            selectedImg.image = UIImage.init(named: "btn_odown")
            let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            selectedImg.transform = transform
        }) { (finished) in
        }
        
        /// 恢复状态
        for index in 0..<3 {
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
    
    /// showLoadingView
    func showLoadingView() {
        
        if (self.loadingView == nil) {
            self.loadingView = SX_LoadingView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        }
        self.view.addSubview(self.loadingView!)
    }
    
    /// hideLoadingView
    func hideLoadingView() {
        let delaySeconds = 0.5
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
      
        
    }
}



