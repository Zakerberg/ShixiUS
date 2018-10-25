//
//  SX_TrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目列表页

/*
 希望你可以把自己挂在淘宝上
 因为你们淘宝承诺过
 淘宝 要淘我喜欢的
 */

import UIKit
import SwiftyJSON

private let ArrowTag   = 3000
private let ControlTag = 1000
private let LabelTag   = 2000

class SX_TrainingProjectController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    var blackBgView: UIView? // 黑色背景弹窗
    var loadingView: SX_LoadingView?
    
    var collectionView: UICollectionView?
    
    var compreNameArr  = [String]()
    var countryNameArr = [String]()
    var trainNameArr   = [String]()
    
    var typeIdArr      = [String]() //中间
    var countryIdArr   = [String]()
    var sortSortArr    = [String]()
    var sortOrderArr   = [String]()
    
    var listsModels    = [TrainingListModel]()
    
    /////用于Search搜索////
    var typeStr: String      = "0"
    var countryStr: String   = "1"
    var sortStr: String      = "id"
    var orderStr: String     = "0"
    /////////////////////
    var baseURL = ""
    
    // 综合排序View
    lazy var comprehensiveView: SX_BasePopSelectedView = {
        let compreView = SX_BasePopSelectedView().addhere(toSuperView: self.view).config({ (COMPREVIEW) in
            COMPREVIEW.backgroundColor   = UIColor.white
            COMPREVIEW.isHidden          = true
        })
        return compreView
    }()
    
    /// 实训类别View
    lazy var trainingView: SX_BasePopSelectedView = {
        let trainingView = SX_BasePopSelectedView().addhere(toSuperView: self.view).config({ (TRAININGVIEW) in
            TRAININGVIEW.backgroundColor = UIColor.white
            TRAININGVIEW.isHidden        = true
        })
        return trainingView
    }()
    
    /// 国家分类View
    lazy var countryView: SX_BasePopSelectedView = {
        let countryView = SX_BasePopSelectedView().addhere(toSuperView: self.view).config({ (COUNTRYVIEW) in
            COUNTRYVIEW.backgroundColor  = UIColor.white
            COUNTRYVIEW.isHidden         = true
        })
        return countryView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Noti()
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

// ===============================================================================
// MARK: - Other Method
// ===============================================================================
extension SX_TrainingProjectController {
    
    func setUI() {
        title = "实训项目"
        view.backgroundColor            = UIColor.white
        setTopSelectedView()
        
        // 创建底部的黑色透明图, 先隐藏
        self.blackBgView = UIView(frame: CGRect(x: 0, y: (self.topSelectedView?.frame.origin.y)! + (self.topSelectedView?.frame.size.height)!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - kNavH - (self.topSelectedView?.frame.size.height)!))
        self.blackBgView?.backgroundColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        self.blackBgView?.alpha    = 0.3
        self.view.insertSubview(self.blackBgView!, aboveSubview: self.collectionView!)
        self.blackBgView?.isHidden = true
        
        let tap = UIGestureRecognizer(target: self, action: #selector(TapClick))
        tap.cancelsTouchesInView   = false
        self.blackBgView?.addGestureRecognizer(tap)
    }
    
    /// 顶部三个按钮 && CollectionView
    func setTopSelectedView() {
        
        let flowLayout      = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        self.collectionView?.backgroundColor                = UIColor.white
        self.collectionView?.delegate                       = self
        self.collectionView?.dataSource                     = self
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.showsVerticalScrollIndicator   = false
        self.collectionView?.register(SX_TrainingCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCellID)
        self.view.insertSubview(self.collectionView!, belowSubview: self.trainingView)
        self.collectionView?.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(kNavH+20.FloatValue.IPAD_XValue)
            make.left.equalToSuperview().offset(Margin)
            make.right.equalToSuperview().offset(-Margin)
            make.bottom.equalToSuperview()
        })
        
        self.topSelectedView = SX_TopSelectedView(frame: CGRect(x: 0, y: kNavH, width: SCREEN_WIDTH, height: 44)).addhere(toSuperView: self.view).config({ (TOPSELECTEDVIEW) in
            TOPSELECTEDVIEW.backgroundColor = UIColor.white
        })
        
        let _ = UIView(frame: CGRect(x: 0, y: self.topSelectedView!.frame.origin.y + self.topSelectedView!.frame.size.height + 0.1 , width: SCREEN_WIDTH, height: 0.5)).addhere(toSuperView: self.view).config { (LINE) in
            LINE.backgroundColor = UIColor.colorWithHexString(hex: "b2b2b2", alpha: 1)
        }
        
        var titleArr = ["综合排序","实训项目","国家"]
        for index in 0..<3 {
            let view = creatBtnView(titleArr[index], frame: CGRect(x: Int((SCREEN_WIDTH/3)) * index, y: 0, width: Int(SCREEN_WIDTH/3), height: 44), tag: index)
            view.isUserInteractionEnabled = true
            self.topSelectedView?.addSubview(view)
            
            let control = UIControl(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
            control.rx.controlEvent(.touchUpInside).subscribe(onNext: { (_) in
                if control.isSelected == true {
                    control.isSelected = false
                    /// 收起
                    self.hideViewWithAnimation(view: self.comprehensiveView)
                    self.hideViewWithAnimation(view: self.trainingView)
                    self.hideViewWithAnimation(view: self.countryView)
                    
                }else if(control.isSelected == false) {
                    control.isSelected = true
                    
                    /// 创建弹窗 选择条件
                    if(control.tag == 1000) {
                        self.showViewWithAnimationAndTag(self.comprehensiveView, tag: control.tag)
                        self.hideViewWithAnimation(view: self.trainingView)
                        self.hideViewWithAnimation(view: self.countryView)
                        
                    } else if(control.tag == 1001) {
                        self.showViewWithAnimationAndTag(self.trainingView, tag: control.tag)
                        self.hideViewWithAnimation(view: self.comprehensiveView)
                        self.hideViewWithAnimation(view: self.countryView)
                        
                    } else if(control.tag == 1002) {
                        self.showViewWithAnimationAndTag(self.countryView, tag: control.tag)
                        self.hideViewWithAnimation(view: self.comprehensiveView)
                        self.hideViewWithAnimation(view: self.trainingView)
                    }
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
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
            }.config { (LABEL) in
                LABEL.text          = title
                LABEL.font          = UIFont.systemFont(ofSize: 14)
                LABEL.textColor     = UIColor.black
                LABEL.textAlignment = .right
                LABEL.tag           = tag + LabelTag
        }
        
        let _ = UIImageView(image: #imageLiteral(resourceName: "btn_down")).addhere(toSuperView: view).layout { (make) in
            make.left.equalTo(label.snp.right).offset(5)
            make.top.equalToSuperview().offset(19)
            make.size.equalTo(CGSize(width: 7, height: 4))
            }.config { (IMAGEV) in
                IMAGEV.tag = tag + ArrowTag
        }
        return view
    }
}

// ===============================================================================
// MARK: - UICollectionViewDelegateFlowLayout
// ===============================================================================
extension SX_TrainingProjectController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listsModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellID, for: indexPath) as! SX_TrainingCollectionViewCell
        
        cell.layer.shadowColor   = UIColor.colorWithHexString(hex: "cccccc", alpha: 0.3).cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius  = 5
        cell.backgroundColor     = UIColor.white
        
        let model  = listsModels[indexPath.item]
        if let url = URL(string: model.image ?? ""){
            cell.sourceImageView?.kf.setImage(with: url)
        }else{
            cell.sourceImageView?.image = #imageLiteral(resourceName: "icon_placeholdericon_Image")
        }
        
        cell.sourceName?.text = model.title ?? "测试项目"
        cell.priceLabel?.text = ("￥" + model.price!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CGFloat(165).IPAD_XValue, height: 165.FloatValue.IPAD_XValue)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: Margin, right: 0)
    }
}

// ===============================================================================
// MARK: - Other Method 2 响应
// ===============================================================================
extension SX_TrainingProjectController {
    func fetchData()  {
        
        baseURL = SHIXIUS + "/training/index?" + "type=\(typeStr)" + "&country=\(countryStr)" + "&sort=\(sortStr)" + "&order=\(orderStr)"
        
        SX_NetManager.requestData(type: .GET, URlString: baseURL, parameters: nil) { (result) in
            do{
                let json = try JSON(data: result)
                /// 成功
                SXLog("成功! ")
                
                self.typeStr    = json["data"]["search"]["type"].string ?? "0"
                self.countryStr = json["data"]["search"]["country"].string ?? "1"
                self.sortStr    = json["data"]["search"]["sort"].string ?? "id"
                self.orderStr   = json["data"]["search"]["type"].string ?? "DESC"
                
                for item in json["data"]["lists"].array ?? [] {
                    let listModel = TrainingListModel(jsonData: item)
                    self.listsModels.append(listModel)
                }
                for item in json["data"]["sort"].array ?? [] {
                    self.compreNameArr.append(item["name"].string ?? "测试综合")
                    self.sortSortArr.append(item["sort"].string ?? "id")
                    self.sortOrderArr.append(item["order"].string ?? "desc")
                    self.comprehensiveView.dataArr = self.compreNameArr
                }
                for item in json["data"]["type"].array ?? [] {
                    self.trainNameArr.append(item["name"].string ?? "测试type")
                    self.typeIdArr.append(item["id"].string ?? "0")
                    self.trainingView.dataArr = self.trainNameArr
                }
                for item in json["data"]["country"].array ?? [] {
                    self.countryNameArr.append(item["name"].string ?? "测试country")
                    self.countryIdArr.append(item["id"].string ?? "1")
                    self.countryView.dataArr = self.countryNameArr
                }
                
                self.comprehensiveView.frame = CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: (self.compreNameArr.count*50))
                self.trainingView.frame      = CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: (self.trainNameArr.count*50))
                self.countryView.frame       = CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: (self.countryNameArr.count*50))
                
                self.collectionView?.reloadData()
            } catch{ }
        }
    }
    
    /// hideView
    func hideViewWithAnimation(view: UIView) {
        self.blackBgView?.isHidden = true
        if view.isHidden == false {
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 5.0, options: .curveEaseInOut, animations: {
                view.frame    = CGRect(x: 0, y: -view.bounds.size.width, width: SCREEN_WIDTH, height: view.bounds.size.height)
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
            self.trainingView.frame = CGRect(x: 0, y: -self.trainingView.bounds.size.height, width: SCREEN_WIDTH, height: self.trainingView.bounds.size.height)
            self.countryView.frame  = CGRect(x: 0, y: -self.countryView.bounds.size.height, width: SCREEN_WIDTH, height: self.countryView.bounds.size.height)
            
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
            control1?.isSelected   = false
            let control2 = self.topSelectedView?.viewWithTag(1001) as? UIControl
            control2?.isSelected   = false
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
            selectedImg.image = #imageLiteral(resourceName: "btn_odown")
            let transform: CGAffineTransform = CGAffineTransform.init(rotationAngle: CGFloat(Double.pi))
            selectedImg.transform = transform
        }) { (finished) in
            SXLog(finished)
        }
        
        /// 恢复状态
        for index in 0..<3 {
            if (index != (tag-ControlTag)) {
                UIView.animate(withDuration: 0.1, animations: {
                    let allImg    = self.topSelectedView?.viewWithTag(index+ArrowTag) as? UIImageView
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
        
    @objc func TapClick() {
        hideViewWithAnimation(view: self.comprehensiveView)
        hideViewWithAnimation(view: self.trainingView)
        hideViewWithAnimation(view: self.countryView)
    }
}

extension SX_TrainingProjectController {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideViewWithAnimation(view: self.comprehensiveView)
        hideViewWithAnimation(view: self.trainingView)
        hideViewWithAnimation(view: self.countryView)
    }
}

// ===============================================================================
// MARK: - RxSwift 通知处理
// ===============================================================================
extension SX_TrainingProjectController {
    func Noti() {
        NotificationCenter.default.rx.notification(NSNotification.Name(rawValue: "CHANGEPOPSELECTDATA")).takeUntil(self.rx.deallocated).subscribe(onNext: { (noti) in
            SXLog("接收到popSelectedView点击的通知")
            self.hideViewWithAnimation(view: self.comprehensiveView)
            self.hideViewWithAnimation(view: self.trainingView)
            self.hideViewWithAnimation(view: self.countryView)
            
            if self.comprehensiveView.isHidden == false {
                SXLog(noti.userInfo?["index"])
                self.listsModels.removeAll()
                self.compreNameArr.removeAll()
                self.trainNameArr.removeAll()
                self.countryNameArr.removeAll()
                //WARNING: 点击indexPath.row 选择对应的 sort数组里面的 sort, order传出去, 然后fetchData
                self.sortStr  = self.sortSortArr[noti.userInfo!["index"] as! Int]
                self.orderStr = self.sortOrderArr[noti.userInfo!["index"] as! Int]
                self.fetchData()
            } else if self.trainingView.isHidden == false {
                SXLog(noti.userInfo?["text"])
                self.listsModels.removeAll()
                self.trainNameArr.removeAll()
                self.compreNameArr.removeAll()
                self.countryNameArr.removeAll()
                self.typeStr  = self.typeIdArr[noti.userInfo!["index"] as! Int]
                self.fetchData()
            } else if self.countryView.isHidden == false {
                SXLog(noti.userInfo?["text"])
                self.listsModels.removeAll()
                self.countryNameArr.removeAll()
                self.compreNameArr.removeAll()
                self.trainNameArr.removeAll()
                self.countryStr = self.countryIdArr[noti.userInfo!["index"] as! Int]
                self.fetchData()
            }
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
    }
}
