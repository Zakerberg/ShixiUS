//
//  SX_TrainingApplyController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目申请

import UIKit

class SX_TrainingApplyController: UIViewController {
    
// ==================================================================================================================================
// MARK: - lazy
// ==================================================================================================================================
    lazy var tableView: UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-CGFloat(kNavH), 0, 0, 0);
        table.delegate   = self
        table.dataSource = self
        
        return table
    }()
    
    lazy var topView: UIView = {
        
        let topView = UIView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
        
            
        }).config({ (topView) in
            
            
        })
        
        return view
    }()
    
    lazy var applyLabel: UILabel = {
        let applyLabel = UILabel().addhere(toSuperView: self.topView).layout(snapKitMaker: { (make) in
            
        }).config({ (applyLabel) in
            
        })
    
        return applyLabel
    }()

    var titleArr = ["姓名", "所在国家", "邮箱", "微信", "年龄", "学校", "专业", "年级", "地址", "推荐人"]
    
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

// ==================================================================================================================================
// MARK: - Other Method
// ==================================================================================================================================
extension SX_TrainingApplyController {
    
    func setUI() {
        
        
    }
    
    func fetchData() {
        
        
    }
}

// ==================================================================================================================================
// MARK: - UITextFieldDelegate
// ==================================================================================================================================
extension SX_TrainingApplyController: UITextFieldDelegate {
    
    
    
    
    
    
}

// ==================================================================================================================================
// MARK: - UITableViewDelegate
// ==================================================================================================================================
extension SX_TrainingApplyController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "trainingApplyCellID")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.FloatValue.IPAD_XValue
    }
}





