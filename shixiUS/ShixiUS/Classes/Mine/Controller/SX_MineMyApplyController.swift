//
//  SX_MineMyApplyController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  我的申请

import UIKit

class SX_MineMyApplyController: UIViewController {

    var listScrollView: UIScrollView?
    var page: NSInteger?
    var status: NSInteger?
    
    lazy var titleHeadView: UIView = {
        let titleHeadView = SX_MineApplyHeadView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            make.top.width.left.right.equalToSuperview()
            make.height.equalTo(41.FloatValue)
        }).config({ (titleHeadView) in
         
            
        })
        
        return titleHeadView
    }()
    
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
extension SX_MineMyApplyController {
    func setUI() {
        title = "我的申请"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.view.addSubview(self.titleHeadView)
        
        if UserDefaults.standard.object(forKey: "isVisitor") as! String == "no"{
            self.view.addSubview(self.listScrollView!)
        } else { // 游客模式
            self.regOrLoginView.isHidden = false
          
            SXLog("此处添加未登录的处理++++")
            
        }
        
        self.tabBarController?.delegate = self
    }
}

// ===============================================================================================================================
// MARK: - UIScrollViewDelegate
// ===============================================================================================================================
extension SX_MineMyApplyController: UIScrollViewDelegate {
    
    
    
    
}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
extension SX_MineMyApplyController: UITableViewDelegate {
    
    
    
    
    
}

// ===============================================================================================================================
// MARK: - UITableViewDelegate
// ===============================================================================================================================
extension SX_MineMyApplyController: UITabBarControllerDelegate {
    
    
    
    
    
    
    
    
    
    
    
}
