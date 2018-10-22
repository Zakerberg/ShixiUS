//
//  SX_CertificationDetailController.swift
//  ShixiUS
//
//  Created by heather on 2018/10/19.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证详情

import UIKit
import SwiftyJSON

class SX_CertificationDetailController: UIViewController {
    var topArr = ["课程介绍", "课程大纲", "名师介绍"]
    
    var id: String?
    var serverImgs = [String]()
    
    lazy var pageTitleView: SX_PageTitleView = {
        let config                = SX_PageTitleViewConfig()
        config.titleColor         = UIColor.colorWithHexString(hex: "333333", alpha: 1)
        config.titleSelectedColor = UIColor.SX_MainColor()
        let pageTitleView = SX_PageTitleView(frame: CGRect(x: 0, y: 200, width: SCREEN_WIDTH, height: 41), titles: self.topArr, config: config)
        pageTitleView.config      = config
        pageTitleView.titles      = self.topArr
        pageTitleView.pageTitleViewDelegate = self
        
        return pageTitleView
    }()
    
    var collectionBtn : UIButton?
    var applyBtn: UIButton?
    
    /// 主 TbaleView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-50.FloatValue.IPAD_XValue), style: .grouped)
        table.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT-CGFloat(kNavH), 0, 0, 0);
        table.delegate     = self as! UITableViewDelegate
        table.dataSource   = self as! UITableViewDataSource
        table.showsVerticalScrollIndicator = false
        
        return table
    }()

    lazy var detailScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .SERVER, imgs: self.serverImgs, descs: nil)
        cycleView.delegate = self
        
        return cycleView
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

// ==============================================================================
// MARK: - Other Method
// ==============================================================================
extension SX_CertificationDetailController {
    func setUI() {
        
        
        
    }
    
    func fetchData() {
        
    }
    
}

// ==============================================================================
// MARK: - 
// ==============================================================================
extension SX_CertificationDetailController: UITableViewDelegate, UITableViewDataSource {
    
    
}

// ==============================================================================
// MARK: -
// ==============================================================================
extension SX_CertificationDetailController {
    
    
}

// ==============================================================================
// MARK: - SXPageTitleViewDelegate
// ==============================================================================
extension SX_CertificationDetailController: SXPageTitleViewDelegate {
    func selectedIndexInPageTitleView(pageTitleView: SX_PageTitleView, selectedIndex: Int) {
        
    }
}
