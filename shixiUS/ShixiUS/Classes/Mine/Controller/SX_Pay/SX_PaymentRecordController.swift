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
    
    var scrollView: UIScrollView?
    var page: NSInteger?
    var status: NSInteger?
    var pageMenu: SPPageMenu?
    var dataArr = ["就业岗位", "实训项目", "职业培训"]
    var myChildViewControllers = NSMutableArray()
    
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

// ======================================================================================================================
// MARK: - Other Method 
// ======================================================================================================================
extension SX_PaymentRecordController {
    
    func setUI() {
        title = "付款记录"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        // trackerStyle 跟踪器的样式
        let pageMenu = SPPageMenu(frame: CGRect(x: 0, y: kNavH, width: SCREEN_WIDTH, height: PageMenuH), trackerStyle: .lineLongerThanItem)
        // 传递数组,默任选择第1个
        pageMenu.setItems(self.dataArr, selectedItemIndex: 0)
        pageMenu.needTextColorGradients = false
        
        pageMenu.delegate = self
        self.view.addSubview(pageMenu)
        self.pageMenu = pageMenu
        
        // 就业岗位, 培训项目, 职业认证
         let controllerClassNames = ["SX_MineEmploymentJobsController", "SX_MineTrainingProjectController", "SX_MineVocationalTrainingController"]
        
        for index in 0...self.dataArr.count {
            if controllerClassNames.count > index{
                guard let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
                    SXLog("获取命名空间失败!")
                    return
                }
                let viewController: AnyClass? = NSClassFromString(spaceName + ".\(controllerClassNames[index])")
                guard let typeClass = viewController as? UIViewController.Type else{
                    SXLog("viewController不能当做UIViewController!")
                    return
                }
                let vc = typeClass.init()
                self.addChildViewController(vc)
                self.myChildViewControllers.add(vc)
            }
        }
        
        self.scrollView = UIScrollView(frame: CGRect(x: 0, y: kNavH+PageMenuH, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        scrollView?.delegate = self
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        self.view.addSubview(scrollView!)
        
        /// 这一行赋值, 可以实现pageMenu的跟踪器时刻跟随scrollView 滑动的效果 ! ! !
        self.pageMenu?.bridgeScrollView = self.scrollView!
        
        /// pageMenu.selectedItemIndex 就是选中的item下标
        if (self.pageMenu?.selectedItemIndex)! < 3 {
            let viewCotroller = self.myChildViewControllers[Int((self.pageMenu?.selectedItemIndex)! as UInt)] as! UIViewController
            scrollView?.addSubview(viewCotroller.view)
            
            viewCotroller.view.frame = CGRect(x: SCREEN_WIDTH*CGFloat((self.pageMenu?.selectedItemIndex)!), y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
            scrollView?.contentOffset =  CGPoint(x: SCREEN_WIDTH*CGFloat((self.pageMenu?.selectedItemIndex)!), y: 0)
            scrollView?.contentSize = CGSize(width: self.dataArr.count.FloatValue*SCREEN_WIDTH, height: 0)
        }
    }
    
    func fetchData() {
        
    }
}

// ======================================================================================================================
// MARK: - SPPageMenuDelegate
// ======================================================================================================================
extension SX_PaymentRecordController: SPPageMenuDelegate {
    
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
        if self.myChildViewControllers.count <= toIndex {return}
        
        let targetViewController = self.myChildViewControllers[toIndex] as! UIViewController
        targetViewController.view.frame = CGRect(x: SCREEN_WIDTH*toIndex.FloatValue, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.scrollView?.addSubview(targetViewController.view)
    }
}

// ======================================================================================================================
// MARK: - UIScrollViewDelegate
// ======================================================================================================================
extension SX_PaymentRecordController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 这一步是实现跟踪器时刻跟随scrollView滑动的效果,如果对self.pageMenu.scrollView赋了值，这一步可省
        //  self.pageMenu?.moveTrackerFollow(scrollView)
    }
}



