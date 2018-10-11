//
//  SX_PaymentRecordController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/24/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  付款记录

/*
 无论我们在这个日子是否在一起
 我也知道
 爱一个人是劫
 有人劫后重生
 有人在劫难逃
 */

import UIKit

class SX_PaymentRecordController: UIViewController {
    
    var dataArr = ["就业岗位", "实训项目", "职业培训"]
    var myChildViewControllers = NSMutableArray()
    var vc = [UIViewController]()
    
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

// =====================================================================================
// MARK: - Other Method 
// =====================================================================================
extension SX_PaymentRecordController {
    
    func setUI() {
        title = "付款记录"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        
        // 就业岗位, 培训项目, 职业认证
        let controllerClassNames = ["SX_PayEmploymentJobsController", "SX_PayTrainingProjectController", "SX_PayVocationalTrainingController"]
        
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
                //self.vc = [vc]
            }
        }
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
    }
    
    func fetchData() {
        
    }
}

// =====================================================================================
// MARK: - SXPageTitleViewDelegate
// =====================================================================================
extension SX_PaymentRecordController: SXPageTitleViewDelegate {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        self.pageContentView.setPageContentViewCurrentIndex(currentIndex: selectedIndex)
    }
}

// =====================================================================================
// MARK: - SXPageContentViewDelegate
// =====================================================================================
extension SX_PaymentRecordController : SXPageContentViewDelegate {
    func pageContentViewScroll(progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
