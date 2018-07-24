//
//  SX_OverseaController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业

import UIKit

class SX_OverseaController: UIViewController {
    
// ==================================================================================================================================
// MARK: - Lazy
// ==================================================================================================================================
    lazy var tableView: UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-CGFloat(kNavH), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()

    
    lazy var overseaScrollerView: SX_CycleScrollerView = {
        let frame = CGRect(x: 0, y: -IMAGE_HEIGHT, width: SCREEN_WIDTH, height: IMAGE_HEIGHT)
        let cycleView = SX_CycleScrollerView(frame: frame, type: .LOCAL, imgs: nil, descs: nil)
        cycleView.delegate = self
        return cycleView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        let localImgs = ["image11","image12","image13","image14","image15"]
        overseaScrollerView.localImgArray = localImgs
        view.addSubview(tableView)
        tableView.tableHeaderView = overseaScrollerView

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.delegate = nil
        print("deinit-----")
    }
}

// ==================================================================================================================================
// MARK: - Other Method
// ==================================================================================================================================
extension SX_OverseaController {
    
    
    
}

// ==================================================================================================================================
// MARK: - Other Method 2 响应
// ==================================================================================================================================
extension SX_OverseaController {
    
    
}

// ==================================================================================================================================
// MARK: - UITableViewDelegate
// ==================================================================================================================================
extension SX_OverseaController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "OverCellId")
        cell.textLabel?.text = "oversea的\(indexPath.row)"
        return cell
    }
}

// ==================================================================================================================================
// MARK: - UIScrollViewDelegate
// ==================================================================================================================================
extension SX_OverseaController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > NAVBAR_COLORCHANGE_POINT) {
            let alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / CGFloat(kNavH)
            navBarBackgroundAlpha = alpha
            navBarTintColor = UIColor.white.withAlphaComponent(alpha)
            navBarTitleColor = UIColor.white.withAlphaComponent(alpha)
            statusBarStyle = .default
            title = "海外就业"
        } else {
            navBarBackgroundAlpha = 0
            navBarTintColor = .clear
            navBarTitleColor = .clear
            statusBarStyle = .lightContent
            title = "海外就业"
        }
    }
}

// ==================================================================================================================================
// MARK: - SXCycleScrollerViewDelegate
// ==================================================================================================================================
extension SX_OverseaController: SXCycleScrollerViewDelegate {
    
    func cycleScrollerDidScroll(to index: Int, cycleScrollerView: SX_CycleScrollerView) {
        
        
    }
    
    func cycleScrollViewDidSelect(at index: Int, cycleScrollView: SX_CycleScrollerView) {
        
        SXLog("点击了oversea\(index)")
    }
}





