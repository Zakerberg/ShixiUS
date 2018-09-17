//
//  SX_MineMyCollectionController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的收藏

/*
 等你时
 我觉得一日不见
 如隔三秋
 
 你朝我笑
 我又觉得
 三秋未见
 不过一日
 */

import UIKit

class SX_MineMyCollectionController: UIViewController {
    
    private var dataArr = ["就业岗位", "实训项目", "职业培训"]
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ====================================================================================================
// MARK: - Other Method
// ====================================================================================================
extension SX_MineMyCollectionController {
    
    func setUI() {
        title = "我的收藏"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        
        // 就业岗位, 培训项目, 职业认证
        let controllerClassNames = ["SX_CollextionEmploymentJobsController", "SX_CollectionTrainingProjectController", "SX_CollectionVocationalTrainingController"]
        
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

// ====================================================================================================
// MARK: - SXPageTitleViewDelegate
// ====================================================================================================
extension SX_MineMyCollectionController: SXPageTitleViewDelegate {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        self.pageContentView.setPageContentViewCurrentIndex(currentIndex: selectedIndex)
    }
}

// ====================================================================================================
// MARK: - SXPageContentViewDelegate
// ====================================================================================================
extension SX_MineMyCollectionController: SXPageContentViewDelegate {
    func pageContentViewScroll(progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView.setPageTitleView(progress: progress, originalIndex: originalIndex, targetIndex: targetIndex)
    }
}
