//
//  SX_CertificationController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/12/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证列表 

/*
 你习惯夜晚，我不再喜欢白天
 你害怕黑暗，我又去盼望黎明的到来
 你渐渐入睡，我便开始想你
 */

import UIKit
import SwiftyJSON

let cellID1 = "cellID"

private let ArrowTag = 3000
private let ControlTag = 1000
private let LabelTag = 2000

class SX_CertificationController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    var blackBgView: UIView? // 黑色背景弹窗
    var loadingView: SX_LoadingView?
    var collectionView: UICollectionView?
    
    var certicationModels = [TrainListModel]()
    
    // 综合排序View
    lazy var comprehensiveView: UIView = {
        let compreView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 160)).addhere(toSuperView: self.view).config({ (compreView) in
            compreView.backgroundColor = UIColor.white
            compreView.dataArr  = ["综合排序","项目时间","价格降序","价格升序"]
            compreView.isHidden = true
            compreView.backgroundColor = UIColor.red
        })
        return compreView
    }()
    
    /// 课程属性View
    private lazy var ClassAttributeView: UIView = {
        let classAttribute = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 200)).addhere(toSuperView: self.view).config({ (ClassAttribute) in
            ClassAttribute.backgroundColor = UIColor.white
        })
        
        classAttribute.dataArr  = ["测试类别1","测试类别2","测试类别3","测试类别4","测试类别5"]
        classAttribute.isHidden = true
        
        return classAttribute
    }()
    
    /// 专业类型View
    private lazy var professionalTypeView: UIView = {
        let professionaltype = SX_BasePopSelectedView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (professionaltype) in
            professionaltype.backgroundColor = UIColor.white
        })
        professionaltype.dataArr  = ["测试类别6","测试类别7","测试类别8","测试类别9"]
        professionaltype.isHidden = true
        
        return professionaltype
    }()
    
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

// ================================================================
// MARK: - Other Method
// ================================================================
extension SX_CertificationController {
    
    func setUI() {
        self.title                         = "培训认证"
        self.view.backgroundColor          = UIColor.white
        self.ClassAttributeView.isHidden   = true
        self.comprehensiveView.isHidden    = true
        self.professionalTypeView.isHidden = true
        setTopSelectedView()
        
    }
    
    func setTopSelectedView() {
        let flowLayout      = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView?.backgroundColor = UIColor.white
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.register(SX_TrainingCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
        self.view.insertSubview(self.collectionView!, belowSubview: self.ClassAttributeView)
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
        
        var titleArr = ["综合排序","课程属性","专业类型"]
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

// ======================================================================
// MARK: - Other Method 2 响应
// ======================================================================
extension SX_CertificationController {
    
    func fetchData() {
        SX_NetManager.requestData(type: .GET, URlString: SX_TrainIndex, parameters: nil) { (result) in
            
            do{
                let json = try JSON(data: result)
                /// 成功
                SXLog("成功! ")
                for item in json["data"]["lists"].array ?? [] {
                    let listModel = TrainListModel(jsonData: item)
                    self.certicationModels.append(listModel)
                }
                self.collectionView?.reloadData()
            } catch{ }
        }
    }
    
    /// 调出PickerView
    @objc func topSelectedBtnClick(control: UIControl) {
        if control.isSelected == true {
            control.isSelected = false
            /// 收起
            hideViewWithAnimation(view: self.comprehensiveView)
            hideViewWithAnimation(view: self.ClassAttributeView)
            hideViewWithAnimation(view: self.professionalTypeView)
            
        }else if(control.isSelected == false) {
            control.isSelected = true
            
            /// 创建弹窗 选择条件
            if(control.tag == 1000) {
                showViewWithAnimationAndTag(self.comprehensiveView, tag: control.tag)
                hideViewWithAnimation(view: self.ClassAttributeView)
                hideViewWithAnimation(view: self.professionalTypeView)
                
            } else if(control.tag == 1001) {
                showViewWithAnimationAndTag(self.ClassAttributeView, tag: control.tag)
                hideViewWithAnimation(view: self.comprehensiveView)
                hideViewWithAnimation(view: self.professionalTypeView)
                
            } else if(control.tag == 1002) {
                showViewWithAnimationAndTag(self.professionalTypeView, tag: control.tag)
                hideViewWithAnimation(view: self.comprehensiveView)
                hideViewWithAnimation(view: self.ClassAttributeView)
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
                    allImg?.image = #imageLiteral(resourceName: "btn_down")
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
            
            self.ClassAttributeView.frame   = CGRect(x: 0, y: -self.ClassAttributeView.bounds.size.height, width: SCREEN_WIDTH, height: self.ClassAttributeView.bounds.size.height)
            self.professionalTypeView.frame = CGRect(x: 0, y: -self.professionalTypeView.bounds.size.height, width: SCREEN_WIDTH, height: self.professionalTypeView.bounds.size.height)
            
            self.ClassAttributeView.isHidden   = true
            self.professionalTypeView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: ClassAttributeView))) {  // 实训项目
            
            self.comprehensiveView.frame    = CGRect(x: 0, y: Int(-self.comprehensiveView.bounds.size.height), width: Int(SCREEN_WIDTH), height: Int(self.comprehensiveView.bounds.size.height))
            self.professionalTypeView.frame = CGRect(x: 0, y: -self.professionalTypeView.bounds.size.height, width: SCREEN_WIDTH, height: self.professionalTypeView.bounds.size.height)
            
            self.comprehensiveView.isHidden    = true
            self.professionalTypeView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1002) as? UIControl
            control2?.isSelected = false
            
        } else if (view.isKind(of: type(of: self.professionalTypeView))) { // 国家
            
            self.comprehensiveView.frame  = CGRect(x: 0, y: -self.comprehensiveView.bounds.size.height, width: SCREEN_WIDTH, height: self.comprehensiveView.bounds.size.height)
            self.ClassAttributeView.frame = CGRect(x: 0, y: -self.ClassAttributeView.bounds.size.height, width: SCREEN_WIDTH, height: self.ClassAttributeView.bounds.size.height)
            
            self.comprehensiveView.isHidden  = true
            self.ClassAttributeView.isHidden = true
            
            let control1 = self.topSelectedView?.viewWithTag(1000) as? UIControl
            control1?.isSelected = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected = false
        }
        
        self.blackBgView?.isHidden = false
        view.isHidden              = false
        
        /// 改变传入的View frame
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseOut, animations: {
            view.frame = CGRect(x: 0, y: self.topSelectedView!.bounds.origin.y + self.topSelectedView!.bounds.size.height + kNavH , width: SCREEN_WIDTH, height: view.bounds.size.height)
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 翻转箭头
        UIView.animate(withDuration: 0.1, animations: {
            let selectedImg = self.topSelectedView?.viewWithTag(tag-ControlTag+ArrowTag) as! UIImageView
            selectedImg.image                = #imageLiteral(resourceName: "btn_odown")
            let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            selectedImg.transform            = transform
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 恢复状态
        for index in 0..<3 {
            if (index != (tag-ControlTag)) {
                UIView.animate(withDuration: 0.1, animations: {
                    let allImg = self.topSelectedView?.viewWithTag(index+ArrowTag) as? UIImageView
                    allImg?.image = #imageLiteral(resourceName: "btn_down")
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
}

// ======================================================================
// MARK: - UICollectionViewDelegate
// ======================================================================
extension SX_CertificationController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.certicationModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath) as! SX_TrainingCollectionViewCell
        
        cell.layer.shadowColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 0.3).cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius  = 5
        cell.backgroundColor     = UIColor.white
        
        let model  = certicationModels[indexPath.item]
        if let url = URL(string: model.image ?? ""){
            cell.sourceImageView?.kf.setImage(with: url)
        }else{
            cell.sourceImageView?.image = #imageLiteral(resourceName: "icon_placeholdericon_Image")
        }
        cell.sourceName?.text       = model.series_name ?? "测试项目"
        cell.certificateLabel?.text = model.category_name ?? "测试分类"
        cell.priceLabel?.text       = ("￥" + model.price!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }
}
