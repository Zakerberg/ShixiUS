//
//  SX_CertificationController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/12/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  培训认证

import UIKit

let cellID1 = "cellID"

class SX_CertificationController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "培训认证"
        self.view.backgroundColor = UIColor.groupTableViewBackground
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==================================================================================================================================
// MARK: - UITableViewDelegate
// ==================================================================================================================================
extension SX_CertificationController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellID1)
        
        return cell

    }
}
