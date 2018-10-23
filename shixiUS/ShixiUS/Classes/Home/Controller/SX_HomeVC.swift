 //
 //  SX_HomeVC.swift
 //  ShixiUS
 //
 //  Created by Michael 柏 on 6/19/18.
 //  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
 //  首页
 
 /*
  我想这世上,
  许多事早已命中注定.
  像江海不可平,
  像走进你心里的路,
  遥遥不可行.
  */
 
 import UIKit
 import RxCocoa
 import RxSwift
 import SwiftyJSON
 
 private let identifier:String = "hotJobsCell"
 private let shixiTrainingCellID = "shixiTrainingCellID"
 
 /// 实训项目视图
 struct InterShipPreview {
    var title:[String]
    var imgs:[String]
    var prices:[String]
 }
 
 class SX_HomeVC: UIViewController {
    
    /// ad
    var adModel:SX_HomeADModel?
    var adImages = [String]()
    var adURLs   = [String]()
    var adTitles = [String]()
    var adIDs    = [Int]()
    var adTypes  = [String]()
    /// ad
    
    //    var homeModel: SX_HomeModel?
    //    var trainingModel: SX_HomeTrainingModel?
    //    var jobsModel: SX_HomeJobsModel?
    //    var trainModel: SX_HomeTrainModel?
    
    /// jobs
    var jobsArr      = JSON()
    /// training
    var trainingArr  = [SX_HomeTrainingModel]()
    /// train
    var trainArr     = [SX_HomeTrainModel]()
    var loadingView: SX_LoadingView?
    
    var cerStr = ""
    private lazy var homeButton: UIButton = {
        let button                        = UIButton()
        button.imageView?.frame           = CGRect(x: 20, y: 20, width: 55, height: 55)
        button.imageView?.center          = CGPoint(x: SCREEN_WIDTH/3, y: 40)
        button.titleLabel?.frame          = CGRect(x: 0, y: 50, width: button.frame.size.width, height: 50)
        button.titleLabel?.textAlignment  = .center
        
        return button
    }()
    
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.contentInset                  = UIEdgeInsetsMake(CGFloat(IMAGE_HEIGHT-kNavH), 0, 0, 0)
        tableView.rowHeight                     = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator  = false
        tableView.estimatedRowHeight            = 200
        tableView.delegate                      = self
        tableView.dataSource                    = self
        
        return tableView
    }()
    
    /// 轮播
    lazy var cycleScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .SERVER, imgs: self.adImages, descs: self.adTitles)
        cycleView.descLabelFont  = UIFont.boldSystemFont(ofSize: 16)
        
        cycleView.delegate = self
        return cycleView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        fetchADData()
        fetchHomeData()
        showLoadingView()
    }
    
    deinit {
        homeTableView.delegate = nil
        print("deinit-----")
    }
 }
 
 // ===========================================================================================
 // MARK: - setUI
 // ===========================================================================================
 extension SX_HomeVC {
    func setUI() {
        view.backgroundColor = UIColor.white
        
        // 设置导航栏颜色
        navBarBarTintColor = UIColor.SX_MainColor()
        // 设置初始导航栏透明度
        navBarBackgroundAlpha = 0
        // 设置导航栏按钮和标题颜色
        navBarTintColor = .white
        
        view.addSubview(homeTableView)
        homeTableView.addSubview(self.cycleScrollerView)
    }
    
    func fetchADData() {
        SX_NetManager.requestData(type: .GET, URlString: SX_HomeAD, parameters:  nil, finishCallBack: { (result) in
            do{
                /// SwiftyJSON 在这里 ! ! !
                let json = try JSON(data: result)
                if json["status"] == 200 {
                    /// 移除LoadingView
                    self.hideLoadingView()                    
                    
                    for (_, subJSON) : (String, JSON) in json["data"] {
                        self.adImages.append(subJSON["image"].string ?? "")
                        self.adTitles.append(subJSON["title"].string ?? "")
                        self.adTypes.append(subJSON["type"].string ?? "")
                    }
                    self.cycleScrollerView.serverImgArray = self.adImages
                    self.cycleScrollerView.descTextArray = self.adTitles
                    self.cycleScrollerView.reloadData()
                    
                } else if json["status"] == 202 {
                    /// 错误状态
                    SXLog("错误状态! ")
                } else if json["status"] == 203 {
                    /// 超时, 重新登录
                    SXLog("超时, 重新登录! ")
                }
            } catch{ }
        })
    }
    
    /// 首页数据
    func fetchHomeData() {
        SX_NetManager.requestData(type: .GET, URlString: SX_Home, parameters:  nil, finishCallBack: { (result) in
            do{
                let json = try JSON(data: result)
                self.jobsArr = JSON(arrayLiteral: json["data"]["jobs"].array ?? [])[0]
                
                for item in json["data"]["training"].array ?? [] {
                    let trainingModel = SX_HomeTrainingModel(jsonData: item)
                    self.trainingArr.append(trainingModel)
                }
                
                for item in json["data"]["train"].array ?? [] {
                    let trainModel = SX_HomeTrainModel(jsonData: item)
                    self.trainArr.append(trainModel)
                }
                self.homeTableView.reloadData()
            } catch{ }
        })
    }
 }
 
 // ==================================================================================================
 // MARK: - Other Method
 // ===================================================================================================
 extension SX_HomeVC {
    
    /// Alert
    func showMessage(_ text:String) {
        let alertController = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "确定", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Version
    func judgeAppVersion() {
        let localVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! NSString
        do {
            _ = NSError()
            var response = try NSURLConnection.sendSynchronousRequest(URLRequest(url: URL(fileURLWithPath: "https://itunes.apple.com/cn/lookup?id=1044254573")), returning: nil)
            if response == nil {
                print("没连接网络")
                
                return
            }
            
            let appInfoDic = try JSONSerialization.jsonObject(with: response, options: .mutableLeaves) as! NSDictionary
            print(appInfoDic)
            let array = appInfoDic["results"] as! NSArray
            if array.count < 1 {
                print("此App未提交")
                
                return
            }
            let dic = array[0] as! NSDictionary
            let appStoreVersion = dic["version"]
            print("当前版本号\(localVersion),商店版本号\(String(describing: appStoreVersion))")
        } catch { }
    }
    
    func showLoadingView() {
        if self.loadingView == nil {
            self.loadingView = SX_LoadingView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        }
        UIApplication.shared.keyWindow?.addSubview(self.loadingView!)
    }
    
    func hideLoadingView() {
        self.loadingView?.removeFromSuperview()
    }
 }
 
 // =====================================================================================================
 // MARK: - UIScrollerViewDelagate
 // =====================================================================================================
 extension SX_HomeVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT)
        {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(SX_NavigationBar.navBarBottom())
            navBarBackgroundAlpha = alpha
            navBarTintColor  = UIColor.white.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.white.withAlphaComponent(alpha)
            statusBarStyle   = .default
            title = "首页"
        } else {
            navBarBackgroundAlpha = 0
            navBarTintColor  = .clear
            navBarTitleColor = .clear
            statusBarStyle   = .lightContent
            title = "首页"
        }
    }
    
    fileprivate func imgsScaledToSize(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newSize.width * 2.0, height: newSize.height * 2.0))
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width * 2.0, height: newSize.height * 2.0))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        return newImage
    }
 }
 
 // =======================================================================================
 // MARK: - UITableViewDelegate
 // =======================================================================================
 extension SX_HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 1 {
            return 90.FloatValue.IPAD_XValue
        }
        
        return 400.FloatValue.IPAD_XValue
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
            
        }else if section == 1{
            return 42
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  section == 1 {
            return self.jobsArr.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 1 {
            let cell                = SX_HotJobsCell(style: .default, reuseIdentifier: identifier)
            cell.selectionStyle     = .none
            
            let model               = jobsArr[indexPath.row]
            
            cell.jobsLabel?.text    = model["name"].string
            cell.insduryLabel?.text = model["trade"].string
            cell.addressLabel?.text = model["address"].string
            cell.eduLabel?.text     = model["nature"].string
            
            return cell
        }
        
        let shixiTrainingCell = SX_TrainingCell(style: .default, reuseIdentifier: shixiTrainingCellID)
        shixiTrainingCell.selectionStyle       = .none
        
        if indexPath.section == 2 { // 2 培训认证
            self.cerStr = "1"
            shixiTrainingCell.titleLabel?.text = "培训认证"
            shixiTrainingCell.trainModels      = self.trainArr
            
        }else{ /// 0 热门实训
            self.cerStr = ""
            shixiTrainingCell.titleLabel?.text = "热门实训"
            shixiTrainingCell.trainingModels   = self.trainingArr
        }
        
        shixiTrainingCell.delegate = self
        shixiTrainingCell.collectionView?.reloadData()
        
        shixiTrainingCell.moreButton?.rx.tap.subscribe(onNext: { (_) in
            SXLog("首页热门实训更多按钮")
            
            let vc = SX_TrainingProjectController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
        
        return shixiTrainingCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView1 = UIView()
            headerView1.backgroundColor = UIColor.white
            let namesArr = ["实训项目","海外就业","培训认证"]
            let imagesArr = ["project","oversea","training"]
            
            for i in 0..<namesArr.count {
                let index = i % 3
                homeButton = UIButton(type: .custom).addhere(toSuperView: headerView1).layout(snapKitMaker: { (make) in
                    make.top.equalToSuperview().offset(Margin)
                    make.left.equalToSuperview().offset(index*Int(SCREEN_WIDTH/3)+30)
                    make.height.lessThanOrEqualTo(100)
                    make.width.lessThanOrEqualTo(70)
                }).config({ (HOMEBTN) in
                    HOMEBTN.setTitleColor(UIColor.black, for: .normal)
                    HOMEBTN.setTitle(namesArr[i], for: .normal)
                    HOMEBTN.titleLabel?.sizeToFit()
                    HOMEBTN.titleEdgeInsets = UIEdgeInsets(top: HOMEBTN.imageView!.frame.size.height+70, left: -HOMEBTN.imageView!.frame.size.width-60, bottom: 0, right: 0)
                    HOMEBTN.contentHorizontalAlignment = .center
                    HOMEBTN.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
                    HOMEBTN.adjustsImageWhenDisabled = false
                    HOMEBTN.setImage(UIImage(named: imagesArr[i]), for: .normal)
                    HOMEBTN.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    HOMEBTN.rx.tap.subscribe(onNext: { (_) in
                        SXLog("首页按钮的点击\(i)")
                        if i == 0 {
                            SXLog("进入实训项目\(i)")
                            self.hidesBottomBarWhenPushed = true
                            let vc = SX_TrainingProjectController()
                            self.navigationController?.pushViewController(vc, animated: true)
                            self.hidesBottomBarWhenPushed = false
                        }else if i == 1 {
                            self.hidesBottomBarWhenPushed = true
                            let vc = SX_MoreHotJobController()
                            self.navigationController?.pushViewController(vc, animated: true)
                            self.hidesBottomBarWhenPushed = false
                        }else if i == 2 {
                            SXLog("进入培训认证\(i)")
                            self.hidesBottomBarWhenPushed = true
                            let vc = SX_CertificationController()
                            self.navigationController?.pushViewController(vc, animated: true)
                            self.hidesBottomBarWhenPushed = false
                        }
                        
                    }, onError: { (error) in
                        SXLog(error)
                    }, onCompleted: nil, onDisposed: nil)
                })
            }
            
            return headerView1
        }else if section == 1 {
            
            let hotJobHeaderView = UIView()
            hotJobHeaderView.backgroundColor = UIColor.white
            
            let hotTitle = UILabel().addhere(toSuperView: hotJobHeaderView).layout { (make) in
                make.top.left.equalTo(hotJobHeaderView).offset(Margin)
                make.height.lessThanOrEqualTo(Margin)
                }.config { (HOTTITLE) in
                    HOTTITLE.sizeToFit()
                    HOTTITLE.text = "热门岗位"
                    HOTTITLE.font = UIFont.systemFont(ofSize: 15)
                    HOTTITLE.textColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
            }
            
            let _ = UIButton().addhere(toSuperView: hotJobHeaderView).layout { (make) in
                make.top.equalTo(hotTitle.snp.top)
                make.height.centerY.equalTo(hotTitle)
                make.right.equalToSuperview().offset(-Margin)
                }.config { (MORE) in
                    MORE.setImage(UIImage.init(named: "more"), for: .normal)
                    MORE.setTitle("更多", for: .normal)
                    MORE.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                    MORE.setTitleColor(UIColor.colorWithHexString(hex: "999999", alpha: 1), for: .normal)
                    MORE.titleEdgeInsets = UIEdgeInsetsMake(0, -MORE.imageView!.bounds.size.width, 0, MORE.imageView!.bounds.size.width)
                    MORE.imageEdgeInsets = UIEdgeInsetsMake(0, MORE.titleLabel!.bounds.size.width, 0, -MORE.titleLabel!.bounds.size.width)
                    MORE.rx.tap.subscribe(onNext: { (_) in
                        SXLog("进入更多界面")
                        let vc = SX_MoreHotJobController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }, onError: { (error) in
                        
                    }, onCompleted: nil, onDisposed: nil)
            }
            return hotJobHeaderView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let model = jobsArr[indexPath.row]
        let vc = SX_HotJobDetailController()
        vc.id  = model["id"].string
        self.navigationController?.pushViewController(vc, animated: true)
    }
 }
 
 // ================================================================================================
 // MARK: - SXCycleScrollerViewDelegate
 // ================================================================================================
 extension SX_HomeVC: SXCycleScrollerViewDelegate {
    
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        if self.adTypes[index] == "training" {
            SXLog("跳转实训详情")
        } else if self.adTypes[index] == "train" {
            SXLog("跳转培训详情")
        }else if self.adTypes[index] == "jobs" {
            SXLog("跳转职位详情")
        }else if self.adTypes[index] == "link" {
            SXLog("网页")
        }
    }
 }
 
 // ================================================================================================
 // MARK: - SX_TrainingCellDelegate
 // ================================================================================================
 extension SX_HomeVC: SX_TrainingCellDelegate {
    func clickCell(item: String) {
        
        if self.cerStr == "1" { /// 培训认证
            let vc = SX_CertificationDetailController()
            vc.id  = item
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = SX_ProjectDetailController()
            vc.id = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
 }
