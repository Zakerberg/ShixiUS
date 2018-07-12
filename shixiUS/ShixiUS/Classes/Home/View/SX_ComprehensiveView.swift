//
//  SX_ComprehensiveView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  综合排序View

import UIKit
private let cellID = "cellID"

class SX_ComprehensiveView: UIView {
    
    var dataArr: [String]?
    
    typealias getComprehensiveChangeClosure = (_ str:NSString) -> Void
    var getComprehensiveStr: getComprehensiveChangeClosure?
    
    private lazy var compreTableView: UITableView = {

        let tableView = UITableView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.edges.equalToSuperview()
        })
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(compreTableView)
        self.dataArr = ["综合排序","项目时间","价格降序","价格升序"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_ComprehensiveView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        cell.textLabel?.text = self.dataArr?[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.black
        cell.accessoryType = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let title = self.dataArr![indexPath.row]
        self.getComprehensiveStr?(title as NSString)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}






