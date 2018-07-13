//
//  SX_OverseaController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  海外就业

import UIKit

private let overseaCellID = "overseaCellID"

class SX_OverseaController: UIViewController {
    
    var topSelectedView: SX_TopSelectedView?
    
//========================================================================================================================================
//  MARK: - lazy
//========================================================================================================================================
    /// 职位分类View
    private lazy var positionView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 440)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["不限","会计服务","航空","银行","电子商务","互联网","表演艺术","翻译和本地化","医疗","服装和时装","测试12"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作性质View
    private lazy var workNatureView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 工作时常View
    private lazy var workTimeView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    /// 发布日期View
    private lazy var releaseDateView: UIView = {
        let positionView = SX_BasePopSelectedView(frame: CGRect(x: 0, y: -241, width: SCREEN_WIDTH, height: 120)).addhere(toSuperView: self.view).config({ (positionView) in
            positionView.backgroundColor = UIColor.white
        })
        positionView.dataArr = ["中国","美国","不限"]
        positionView.isHidden = true
        
        return positionView
    }()
    
    
    private lazy var overseaTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
//========================================================================================================================================
//
//========================================================================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "海外就业"
        self.view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_OverseaController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: overseaCellID)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = "测试cell"
        return cell
    }
}

// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_OverseaController {
    
    
    
    
    
}
