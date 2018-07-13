//
//  SX_CountryView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  国家View

import UIKit

private let countryCellID = "countryCellID"

class SX_CountryView: UIView {

    var dataArr:[String]?
    
    private lazy var countryTableView: UITableView = {
        
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
        self.addSubview(countryTableView)
        self.dataArr = ["中国","美国","不限"]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// ========================================================================================================================================
// MARK: - UITableViewDelegate
// ========================================================================================================================================
extension SX_CountryView: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: countryCellID)
        cell.textLabel?.text = self.dataArr?[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.black
        cell.accessoryType = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        SXLog("点击了taining\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// ========================================================================================================================================
// MARK: - Other Method
// ========================================================================================================================================
extension SX_CountryView {
    
    
    
    
    
}
