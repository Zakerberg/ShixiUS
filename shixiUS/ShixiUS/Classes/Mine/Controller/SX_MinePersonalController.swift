//
//  SX_MinePersonalController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  个人信息

import UIKit

class SX_MinePersonalController: UIViewController {

    lazy var table: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: Int(SCREEN_HEIGHT)), style: .plain)
        tableView.backgroundColor = UIColor.SX_BackGroundColor()
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate   = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MinePersonalController {
    

    
    
    
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MinePersonalController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        
        
        
        
        
        return cell
    }
}

// ===============================================================================================================================
// MARK: -
// ===============================================================================================================================
extension SX_MinePersonalController {
    
 
    
    
    
    
    
    
}









