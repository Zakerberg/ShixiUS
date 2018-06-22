//
//  SX_HomeVC.swift
//  ShixiUS
//
//  Created by Michael 柏 on 6/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit
import Alamofire

class SX_HomeVC: UIViewController {
    
    let adScrollView = SX_ADScrollerView(Y: 0, H: 200)
    var homeTableView: UITableView?
    // 导航栏背景视图
    var barImageView: UIView?
    // KVO实例
    var observation: NSKeyValueObservation?
    
    // 视图显示的时候触发
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //使用kvo来监听视图偏移量变化
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
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.navigationBar.barTintColor = UIColor.SX_MainColor()
        self.barImageView = self.navigationController?.navigationBar.subviews.first
        
         self.homeTableView = UITableView(frame: self.view.frame, style: .plain)
       // self.homeTableView = UITableView(frame: CGRect(x: 0, y: -kNavH, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-kTabBarHeight), style: .plain)
        self.homeTableView?.delegate = self
        self.homeTableView?.dataSource = self
        self.homeTableView?.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.homeTableView!)
    }
}

extension SX_HomeVC {
    
    
    
    
    
    
}

//MARK: - UIScrollerViewDelagate
extension SX_HomeVC {
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offSetY = scrollView.contentOffset.y
    }
}

//MARK: - UITableViewDelegate
extension SX_HomeVC : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 50
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identify:String = "SwiftCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "测试条目\(indexPath.row)"
        
        return cell
    }
    
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        if section == 0 {
//            return 300
//        }
//
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        if section == 0 {
//
//
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.blue
//
//
//        return headerView
//        }
//        let view = UIView()
//        return view
//
//
//    }
    
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


