//
//  SX_MyApplyController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/14/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请

import UIKit
let PageMenuH = 40.FloatValue

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
        
        let controllerClassNames = NSArray.init(array: [""])
        
        
        
        
    }
}

// ===============================================================================================================================
// MARK: - SPPageMenuDelegate
// ===============================================================================================================================
extension SX_MyApplyController: SPPageMenuDelegate {
    
    
    
    
    
    
    
    
    
    
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MyApplyController {
    
    
    
    
    
    
    
    
    
}
