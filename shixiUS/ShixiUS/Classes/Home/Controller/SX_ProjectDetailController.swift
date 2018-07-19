//
//  SX_ProjectDetailController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/18/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目详情

import UIKit


class SX_ProjectDetailController: UIViewController {

// =================================================================================================================================
// MARK: - Other Method
// =================================================================================================================================
    lazy var tableView:UITableView = {
        let table:UITableView = UITableView(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.bounds.height), style: .plain)
        table.contentInset = UIEdgeInsetsMake(-CGFloat(kNavH), 0, 0, 0);
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
//    lazy var topView:UIImageView = {
//        let imgView = UIImageView(image: UIImage(named: "wbBg"))
//        imgView.frame = CGRect(x: 0, y: 0, width: Int(SCREEN_WIDTH), height: IMAGE_HEIGHT)
//        imgView.contentMode = UIViewContentMode.scaleAspectFill
//        imgView.clipsToBounds = true
//        return imgView
//    }()
//    

    
    
    
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

// =================================================================================================================================
// MARK: - UITableViewDelegate
// =================================================================================================================================
extension SX_ProjectDetailController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellidentifier")
        cell.textLabel?.text = "这是projectController的\(indexPath.row)"
        
        return cell
    }
}

// =================================================================================================================================
// MARK: - Other Method
// =================================================================================================================================
extension SX_ProjectDetailController {
    
    func setUI() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        view.addSubview(self.tableView)
}
    
    
    func fetchData() {
        
        
        
    }
}

