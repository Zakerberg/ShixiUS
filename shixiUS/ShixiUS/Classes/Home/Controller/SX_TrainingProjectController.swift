//
//  SX_TrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目VC

import UIKit

class SX_TrainingProjectController: UIViewController {

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

extension SX_TrainingProjectController {
    
    /// setUI
    func setUI() {
        self.view.backgroundColor = UIColor.white
    }
    
    /// fetchData
    func fetchData()  {
        
    }
}



