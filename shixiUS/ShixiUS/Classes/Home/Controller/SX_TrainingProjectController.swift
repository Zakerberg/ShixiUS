//
//  SX_TrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目VC

import UIKit

private let ArrowTag = 3000
private let ControlTag = 1000
private let LabelTag = 2000

class SX_TrainingProjectController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    var blackBgView: UIView? // 黑色背景弹窗
    var loadingView: SX_LoadingView?
    
// ========================================================================================================================================
// MARK: - lazy
// ========================================================================================================================================
    /// 综合排序View
    private lazy var comprehensiveView: UIView = {
        let comprehensiveView = UIView()
        return comprehensiveView
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
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = false
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
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.tintColor = UIColor.SX_MainColor()
        
        self.trainingView.isHidden = true
        self.comprehensiveView.isHidden = true
        self.countryView.isHidden = true
    }
    
    func setleftBackButton() {
        
        let _ = UIButton(type:.custom).addhere(toSuperView: self.view).layout { (make) in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(44)
            }.config { (leftBtn) in
                leftBtn.setImage(UIImage.init(named: ""), for: .normal)
                leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0)
                leftBtn.rx.tap.subscribe(onNext: { (_) in
                    self.navigationController?.popViewController(animated: true)
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
                let backItem = UIBarButtonItem(customView: leftBtn)
                self.navigationItem.leftBarButtonItem = backItem
                self.navigationController?.interactivePopGestureRecognizer?.delegate = self as! UIGestureRecognizerDelegate
        }
    }
    
    
    /// 顶部三个按钮
    func setTopSelectedView() {
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (topSelectedView) in
            topSelectedView.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (lineView) in
            lineView.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        let titleArr = ["综合排序","实训项目","国家"]
        for index in 0...3 {
            let title = titleArr[index]
            let view = creatBtnView(title, frame: CGRect(x: Int((SCREEN_WIDTH/3)) * index, y: 0, width: Int(SCREEN_WIDTH/3), height: 44), tag: index)
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
        view.backgroundColor = UIColor.white
        
        let label = UILabel().addhere(toSuperView: view).layout { (make) in
            make.centerX.equalToSuperview().offset(-6)
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 65, height: 14))
            }.config { (label) in
                label.font = UIFont.systemFont(ofSize: 14)
                label.textColor = UIColor.colorWithHexString(hex: "323232", alpha: 1)
                label.lineBreakMode = .byTruncatingMiddle
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
            
            if(control.tag == 1000) {
              
             
                
                
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
                for index in 0...3 {
                    
                    let allImg = self.topSelectedView?.viewWithTag(ArrowTag + index) as! UIImageView
                    allImg.image = UIImage.init(named: "btn_down")
                    let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(-Double.pi)*0)
                    allImg.transform = transform
                    
                    let allLabel = self.topSelectedView?.viewWithTag(LabelTag + index) as! UILabel
                    allLabel.textColor = UIColor.black
                }
                
            }) { (finished) in
                
            }
        }
    }
    
    /// 展示隐藏动画
    func showViewWithAnimationAndTag(_ view: UIView, tag: NSInteger) {
        if view.isKind(of: type(of: self.comprehensiveView)) {
        
            self.comprehensiveView.frame = CGRect(x: 0, y: -self.comprehensiveView.bounds.size.height, width: SCREEN_WIDTH, height: self.comprehensiveView.bounds.size.height)
            
            self
            
            
            
            
        
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
    
    /// showLoadingView
    func showLoadingView() {
        
        
        
    }
    
    /// hideLoadingView
    func hideLoadingView() {
     
        
        
    }
}








