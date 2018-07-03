//
//  SX_HomeVC.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit
import RxSwift

private let NAVBAR_COLORCHANGE_POINT = -80
private let IMAGE_HEIGHT:CGFloat = 240
private let SCROLL_DOWN_LIMIT: CGFloat = 100
private let LIMIT_OFFSET_Y:CGFloat = -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)
private let identifier:String = "hotJobsCell"

/// 实训项目视图
struct InterShipPreview {
    var title:[String]
    var imgs:[String]
    var prices:[String]
}

class SX_HomeVC: UIViewController {
    
    private lazy var homeButton: UIButton = {
        let button = UIButton()
        button.imageView?.frame = CGRect(x: 20, y: 20, width: 55, height: 55)
        button.imageView?.center = CGPoint(x: SCREEN_WIDTH/3, y: 40)
        button.titleLabel?.frame = CGRect(x: 0, y: 50, width: button.frame.size.width, height: 50)
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-kNavH, 0, 0, 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 200
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    // 轮播
    private lazy var cycleScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .SERVER, imgs: nil, descs: nil)
        
        return cycleView
    }()
    
    /****
     // KVO实例
     var observation: NSKeyValueObservation?
     // 视图显示的时候触发
     override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     
     // 使用kvo来监听视图偏移量变化
     observation = self.homeTableView!.observe(\.contentOffset, options: [.new, .old]) {
     [unowned self] homeTableView, changed in
     //根据偏移量修改导航栏透明度
     var delta = changed.newValue!.y / CGFloat(0) + 1
     delta = CGFloat.maximum(delta, 0)
     self.barImageView?.alpha = CGFloat.minimum(delta, 1)
     }
     }
     
     //视图消失的时候调用
     override func viewWillDisappear(_ animated: Bool) {
     super.viewDidDisappear(animated)
     // 移除kvo
     observation?.invalidate()
     }
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        /**** ======================================================================================================
         let NetImgArr = Array<Any>()
         let descLabelArr = Array<Any>()
         cycleScrollerView.serverImgArray = NetImgArr as? [String]
         cycleScrollerView.descTextArray  = descLabelArr as? [String]
         ====================================================================================================== *****/
        
        let localImgs = ["localImg6","localImg7","localImg8","localImg9","localImg10"]
        let descLabels = ["韩国防部回应停止部署萨德:遵照最高统帅指导方针",
                          "勒索病毒攻击再次爆发 国内校园网大面积感染",
                          "Win10秋季更新重磅功能：跟安卓与iOS无缝连接",
                          "《琅琊榜2》为何没有胡歌？胡歌：我看过剧本，离开是种保护",
                          "阿米尔汗在印度的影响力，我国的哪位影视明星能与之齐名呢？"]
        
        cycleScrollerView.localImgArray = localImgs
        cycleScrollerView.descTextArray = descLabels
        cycleScrollerView.descLabelFont  = UIFont.boldSystemFont(ofSize: 16)
        homeTableView.addSubview(cycleScrollerView)
        view.addSubview(homeTableView)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.SX_MainColor()
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    deinit {
        homeTableView.delegate = nil
        print("deinit")
    }
}

// ========================================================================================================================
// MARK: - UIScrollerViewDelagate
// ========================================================================================================================
extension SX_HomeVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSetY = scrollView.contentOffset.y
        if (offSetY > CGFloat(NAVBAR_COLORCHANGE_POINT)) {
            let alpha = (offSetY - CGFloat(NAVBAR_COLORCHANGE_POINT)) / CGFloat(kNavH)
            
            self.navigationController?.navigationBar.alpha = alpha
        }else {
            self.navigationController?.navigationBar.alpha = 0
        }
        
        if (offSetY < LIMIT_OFFSET_Y) {
            scrollView.contentOffset = CGPoint.init(x: 0, y: LIMIT_OFFSET_Y)
        }
        
        // 改变图片框的大小 (上滑的时候不改变)
        // 这里不能使用offsetY，因为当（offsetY < LIMIT_OFFSET_Y）的时候，y = LIMIT_OFFSET_Y 不等于 offsetY
        let newOffsetY = scrollView.contentOffset.y
        if (newOffsetY < -IMAGE_HEIGHT)
        {
            cycleScrollerView.frame = CGRect(x: 0, y: newOffsetY, width: CGFloat(SCREEN_WIDTH), height: -newOffsetY)
        }
    }
    
    fileprivate func imgsScaledToSize(image: UIImage, newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: newSize.width * 2.0, height: newSize.height * 2.0))
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width * 2.0, height: newSize.height * 2.0))
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() ?? image
        return newImage
    }
}

// ========================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================
extension SX_HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
     return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        }
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if  section == 1 {
            return 4
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SX_HotJobsCell(style: .default, reuseIdentifier: identifier)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.white
            let arr = ["实训项目","海外就业","培训认证"]
            
            for i in 0..<arr.count {
                
                let index = i % 3
                let page = i / 3
                homeButton = UIButton()
                homeButton.frame = CGRect(x: index*Int(SCREEN_WIDTH/3), y: page*(85), width: Int(SCREEN_WIDTH/3), height: 100)
                homeButton.titleLabel?.lineBreakMode = .byWordWrapping
                homeButton.titleLabel?.numberOfLines = 0
                homeButton.setTitleColor(UIColor.black, for: .normal)
                
                homeButton.titleLabel?.textAlignment = .center
                //shomeButton.setTitle(arr[i], for: .normal)
                homeButton.setImage(UIImage(named: arr[i]), for: .normal)
                homeButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                homeButton.addTarget(self, action: #selector(homeButtonClick), for: .touchUpInside)
                
                headerView.addSubview(homeButton)
            }
            
            return headerView
        }
        
        let view = UIView()
        return view
    }
    
    @objc func homeButtonClick() {
        SXLog("111")
    }
}

//MARK: - 版本判断
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


