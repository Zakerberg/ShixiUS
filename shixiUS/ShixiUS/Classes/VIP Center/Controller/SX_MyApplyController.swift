//
//  SX_MyApplyController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请

/*
 是你绑架我到你心里,
 我又没钱交赎金,
 如果你不撕票,
 我会用一生的爱,
 慢慢还你.
 */

import UIKit

class SX_MyApplyController: UIViewController {
    
    var dataArr = ["就业岗位", "实训项目", "职业培训"]
    var myChildViewControllers = NSMutableArray()
    var vc = [UIViewController]()
    
    lazy var regOrLoginView: UIView = {
        let regOrLoginView = UIView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT-154)
        }).config({ (regOrLoginView) in
            regOrLoginView.isHidden = true
        })
        return regOrLoginView
    }()
    
    private lazy var pageTitleView: SX_PageTitleView = {
        let config                = SX_PageTitleViewConfig()
        config.titleColor         = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        config.titleSelectedColor = UIColor.SX_MainColor()
        
        let pageTitleView = SX_PageTitleView(frame: CGRect(x: 0, y: navHeight, width: SCREEN_WIDTH, height: 41), titles: self.dataArr, config: config)
        pageTitleView.pageTitleViewDelegate = self
        
        return pageTitleView
    }()
    
    private lazy var pageContentView: SX_PageContentView = {
        
        let pageContentViewY = pageTitleView.frame.maxY
        let pageContentView = SX_PageContentView(frame: CGRect(x: 0, y: pageContentViewY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-pageContentViewY), parentVC: self, childVCs: vc)
        pageContentView.pageContentViewDelegate = self
        
        return pageContentView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //autoRefresh()
        SXLog("此处 的 自动刷新没写 !  !   !  ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ///接收 登陆界面 back 的通知, 退回之前tabbbar
        NotificationCenter.default.addObserver(self, selector: #selector(toPresentTabbar), name: NSNotification.Name(rawValue: "TOPRESENTTABBAR"), object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        SXLog("父控制器被销毁了...")
    }
}

// =============================================================
// MARK: - Other Method
// =============================================================
extension SX_MyApplyController {
    
    func setUI() {
        title = "我的申请"
        self.view.backgroundColor = UIColor.white
            // 就业岗位, 培训项目, 职业认证
            let controllerClassNames = ["SX_MineEmploymentJobsController", "SX_MineTrainingProjectController", "SX_MineVocationalTrainingController"]
            
            for index in 0..<self.dataArr.count {
                if controllerClassNames.count > index {
                    guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                        SXLog("获取命名空间失败!")
                        return
                    }
                    
                    let viewController: AnyClass? = NSClassFromString(spaceName + ".\(controllerClassNames[index])")
                    guard let typeClass = viewController as? UIViewController.Type else {
                        SXLog("viewController不能当做UIViewController!")
                        return
                    }
                    
                    let vc = typeClass.init()
                    self.addChildViewController(vc)
                    self.myChildViewControllers.add(vc)
                    self.vc.append(vc)
                }
            }
            view.addSubview(pageTitleView)
            view.addSubview(pageContentView)
    }
}

// =============================================================
// MARK: - SXPageTitleViewDelegate
// =============================================================
extension SX_MyApplyController: SXPageTitleViewDelegate {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        self.pageContentView.setPageContentViewCurrentIndex(currentIndex: selectedIndex)
    }
}

// =============================================================
// MARK: - SXPageContentViewDelegate
// =============================================================
extension SX_MyApplyController: SXPageContentViewDelegate {
    func pageContentViewScroll(progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}

// =============================================================
// MARK: - Noti
// =============================================================
extension SX_MyApplyController {
    @objc func toPresentTabbar(noti:Notification) {
        SXLog("接收到通知")
       let numiss = USERDEFAULTS.value(forKey: "tabBarSelectedIndex")
        self.tabBarController?.selectedIndex = numiss as! Int
    }
}
