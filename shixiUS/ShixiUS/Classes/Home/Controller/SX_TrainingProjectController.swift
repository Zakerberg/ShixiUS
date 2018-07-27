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
    var projectCollectionView: UICollectionView?
    var collectionView: UICollectionView?
    
// ==================================================================================================================================
//  MARK: - lazy
// ==================================================================================================================================
// 综合排序View
    lazy var comprehensiveView: UIView = {
        let compreView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 160)).addhere(toSuperView: self.view).config({ (compreView) in
            compreView.backgroundColor = UIColor.white
            compreView.dataArr = ["综合排序","项目时间","价格降序","价格升序"]
            compreView.isHidden = true
            compreView.backgroundColor = UIColor.red
        })
        return compreView
    }()
    
    /// 实训类别View
    private lazy var trainingView: UIView = {
        let trainingView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200)).addhere(toSuperView: self.view).config({ (trainingView) in
            trainingView.backgroundColor = UIColor.white
        })
        
        trainingView.dataArr = ["测试类别1","测试类别2","测试类别3","测试类别4","测试类别5"]
        trainingView.isHidden = true
        
        return trainingView
    }()
    
    /// 国家分类View
    private lazy var countryView: UIView = {
        let countryView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (countryView) in
            countryView.backgroundColor = UIColor.white
        })
        countryView.dataArr = ["中国","美国","不限"]
        countryView.isHidden = true
        
        return countryView
    }()
    
    private lazy var BlackBgView: UIView = {
        self.blackBgView = UIView(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        self.blackBgView?.backgroundColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        self.blackBgView?.alpha = 0.5
        
        self.blackBgView?.isHidden = true
        
        return blackBgView!
    }()
    
// ==================================================================================================================================
// MARK: - O
// ==================================================================================================================================
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==================================================================================================================================
// MARK: - UITableViewDelegate, UICollectionViewDelegateFlowLayout
// ==================================================================================================================================
extension SX_TrainingProjectController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath) as! SX_TrainingCollectionViewCell
        
        cell.layer.shadowColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 0.3).cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.backgroundColor = UIColor.white
        
        cell.sourceImageView?.image = UIImage.init(named: "localImg3")
        cell.priceLabel?.text = "￥" + "2998.00"
        cell.sourceName?.text = "课程名称课程名称测试"
        cell.certificateLabel?.text = "职业技术证书"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }
}

// ==================================================================================================================================
// MARK: - Other Method
// ==================================================================================================================================
extension SX_TrainingProjectController {
    
    func setUI() {
        self.title = "实训项目"
        self.view.backgroundColor = UIColor.white
        self.trainingView.isHidden = true
        self.comprehensiveView.isHidden = true
        self.countryView.isHidden = true
        setTopSelectedView()
    }
    
    /// 顶部三个按钮 && CollectionView
    func setTopSelectedView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.register(SX_TrainingCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
        self.view.insertSubview(self.collectionView!, belowSubview: self.trainingView)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(kNavH+55)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.bottom.equalToSuperview()
        })
        
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: kNavH, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (topSelectedView) in
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

// =================================================================================================================================
// MARK: - Other Method 2 响应
// ==================================================================================================================================
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
                hideViewWithAnimation(view: self.trainingView)
                hideViewWithAnimation(view: self.countryView)
                
            } else if(control.tag == 1001) {
                showViewWithAnimationAndTag(self.trainingView, tag: control.tag)
                hideViewWithAnimation(view: self.comprehensiveView)
                hideViewWithAnimation(view: self.countryView)
                
            } else if(control.tag == 1002) {
                showViewWithAnimationAndTag(self.countryView, tag: control.tag)
                hideViewWithAnimation(view: self.comprehensiveView)
                hideViewWithAnimation(view: self.trainingView)
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
                SXLog(finished)
            }
        }
    }
    
    /// 展示隐藏动画
    func showViewWithAnimationAndTag(_ view: UIView, tag: NSInteger) {
        
        if view.isKind(of: type(of: self.comprehensiveView)) { //综合
            
            self.trainingView.frame = CGRect(x: 0, y: -self.trainingView.bounds.size.height, width: SCREEN_WIDTH, height: self.trainingView.bounds.size.height)
            self.countryView.frame = CGRect(x: 0, y: -self.countryView.bounds.size.height, width: SCREEN_WIDTH, height: self.countryView.bounds.size.height)
            
            self.trainingView.isHidden = true
            self.countryView.isHidden  = true
            
            let control1 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: trainingView))) {  // 实训项目
            
            self.comprehensiveView.frame = CGRect(x: 0, y: Int(-self.comprehensiveView.bounds.size.height), width: Int(SCREEN_WIDTH), height: Int(self.comprehensiveView.bounds.size.height))
            self.countryView.frame = CGRect(x: 0, y: -self.countryView.bounds.size.height, width: SCREEN_WIDTH, height: self.countryView.bounds.size.height)
            
            self.comprehensiveView.isHidden = true
            self.countryView.isHidden       = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: self.countryView))) { // 国家
            
            self.comprehensiveView.frame = CGRect(x: 0, y: -self.comprehensiveView.bounds.size.height, width: SCREEN_WIDTH, height: self.comprehensiveView.bounds.size.height)
            self.trainingView.frame = CGRect(x: 0, y: -self.trainingView.bounds.size.height, width: SCREEN_WIDTH, height: self.trainingView.bounds.size.height)
            
            self.comprehensiveView.isHidden  = true
            self.trainingView.isHidden       = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected = false
        }
        
        self.blackBgView?.isHidden = false
        view.isHidden = false
        
        /// 改变传入的View frame
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: self.topSelectedView!.bounds.origin.y + self.topSelectedView!.bounds.size.height + kNavH , width: SCREEN_WIDTH, height: view.bounds.size.height)
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
    
    //    /// showLoadingView
    //    func showLoadingView() {
    //
    //        if (self.loadingView == nil) {
    //            self.loadingView = SX_LoadingView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
    //        }
    //        self.view.addSubview(self.loadingView!)
    //    }
    //
    //    /// hideLoadingView
    //    func hideLoadingView() {
    //        let delaySeconds = 0.5
    //
    //    }
    //
    //    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //    }
}

