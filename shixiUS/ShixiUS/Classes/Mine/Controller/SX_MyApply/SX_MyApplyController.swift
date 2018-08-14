//
//  SX_MyApplyController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请

import UIKit
let PageMenuH        = 40.FloatValue
let scrollViewHeight = SCREEN_WIDTH-88-PageMenuH

class SX_MyApplyController: UIViewController {
    
    var scrollView: UIScrollView?
    var page: NSInteger?
    var status: NSInteger?
    var pageMenu: SPPageMenu?
    var dataArr = ["就业岗位", "实训项目", "职业培训"]
    var myChildViewControllers: NSMutableArray?
    
    lazy var regOrLoginView: UIView = {
        let regOrLoginView = UIView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(SCREEN_HEIGHT-154)
        }).config({ (regOrLoginView) in
            regOrLoginView.isHidden = true
        })
        return regOrLoginView
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //autoRefresh()
        SXLog("此处 的 自动刷新没写 !  !   !  ")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_MyApplyController {
    func setUI() {
        title = "我的申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        
        // trackerStyle 跟踪器的样式
        let pageMenu = SPPageMenu(frame: CGRect(x: 0, y: kNavH, width: SCREEN_WIDTH, height: PageMenuH), trackerStyle: .lineLongerThanItem)
        // 传递数组,默任选择第2个
        pageMenu.setItems(self.dataArr, selectedItemIndex: 1)
        pageMenu.needTextColorGradients = false
        
        pageMenu.delegate = self
        self.view.addSubview(pageMenu)
        self.pageMenu = pageMenu
        
        // 就业岗位, 培训项目, 职业认证
        let controllerClassNames = NSArray.init(array: ["SX_ApplyEmploymentJobsController", "SX_ApplyTrainingProjectController", "SX_ApplyVocationalTrainingController"])
        
        for index in 0...self.dataArr.count {
            if controllerClassNames.count > index{
                let viewController = NSClassFromString(controllerClassNames[index] as! String)
                self.addChildViewController(viewController as! UIViewController)
                self.myChildViewControllers?.add(viewController!)
            }
        }
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: kNavH+PageMenuH, width: SCREEN_WIDTH, height: scrollViewHeight))
        scrollView?.delegate = self
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView!)
        
        /// 这一行赋值, 可以实现pageMenu的跟踪器时刻跟随scrollView 滑动的效果 ! ! !
        self.pageMenu?.bridgeScrollView = self.scrollView!
        
        /// pageMenu.selectedItemIndex 就是选中的item下标
        if (self.pageMenu?.selectedItemIndex)! < 3 {
            
            let viewCotroller = self.myChildViewControllers![Int((self.pageMenu?.selectedItemIndex)! as UInt)] as! UIViewController
            scrollView?.addSubview(viewCotroller.view)
            viewCotroller.view.frame = CGRect(x: SCREEN_WIDTH*CGFloat((self.pageMenu?.selectedItemIndex)!), y: 0, width: SCREEN_WIDTH, height: scrollViewHeight)
            scrollView?.contentOffset =  CGPoint(x: SCREEN_WIDTH*CGFloat((self.pageMenu?.selectedItemIndex)!), y: 0)
            scrollView?.contentSize = CGSize(width: self.dataArr.count.FloatValue*SCREEN_WIDTH, height: 0)
        }
    }
}

// ===============================================================================================================================
// MARK: - SPPageMenuDelegate
// ===============================================================================================================================
extension SX_MyApplyController: SPPageMenuDelegate {
    
    func pageMenu(_ pageMenu: SPPageMenu, itemSelectedAt index: Int) {
        SXLog(index)
    }
    
    func pageMenu(_ pageMenu: SPPageMenu, itemSelectedFrom fromIndex: Int, to toIndex: Int) {
        SXLog("\(fromIndex) ---- \(toIndex)")
        
        // 如果formIndex和toIndex之差>=2 ,说明跨界面移动了, 此时不动画
        if labs(toIndex - fromIndex) >= 2 {
            self.scrollView?.setContentOffset(CGPoint(x: SCREEN_WIDTH*toIndex.FloatValue, y: 0), animated: false)
        } else {
            self.scrollView?.setContentOffset(CGPoint(x: SCREEN_WIDTH*toIndex.FloatValue, y: 0), animated: true)
        }
        if (self.myChildViewControllers?.count)! <= toIndex {return}
        
        let targetViewController = self.myChildViewControllers![toIndex] as! UIViewController
        targetViewController.view.frame = CGRect(x: SCREEN_WIDTH*toIndex.FloatValue, y: 0, width: SCREEN_WIDTH, height: scrollViewHeight)
        self.scrollView?.addSubview(targetViewController.view)
    }
}

// ===============================================================================================================================
// MARK: - UIScrollViewDelegate
// ===============================================================================================================================
extension SX_MyApplyController: UIScrollViewDelegate {
    
    
    
    
    
    
    
}
