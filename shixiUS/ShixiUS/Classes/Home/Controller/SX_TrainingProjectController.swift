//
//  SX_TrainingProjectController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实训项目VC

import UIKit

class SX_TrainingProjectController: UIViewController {
    
    // ========================================================================================================================
    // MARK: - lazy
    // ========================================================================================================================
    /// 综合排序View
    private lazy var comprehensiveView: UIView = {
        let comprehensiveView = UIView()
        return comprehensiveView
    }()
    
    /// 实训类别View
    private lazy var trainingView: UIView = {
        let trainingView = UIView()
        return trainingView
    }()
    
    /// 国家分类View
    private lazy var countryView: UIView = {
        let countryView = UIView()
        return countryView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
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

// ========================================================================================================================
// MARK: - Other Method
// ========================================================================================================================
extension SX_TrainingProjectController {
    func setUI() {
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.tintColor = UIColor.SX_MainColor()
        
        self.trainingView.isHidden = true
        self.comprehensiveView.isHidden = true
        self.countryView.isHidden = true
    }

    func setleftBackButton() {
        
        let _ = UIButton(type:.custom).addhere(toSuperView: self.view).layout { (make) in
            make.top.left.equalToSuperview()
            make.width.height.equalTo(44)
            }.config { (leftBtn) in
                leftBtn.setImage(UIImage.init(named: ""), for: .normal)
                leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0)
                leftBtn.rx.tap.subscribe(onNext: { (_) in
                    self.navigationController?.popViewController(animated: true)
                }, onError: { (error) in
                    SXLog(error)
                }, onCompleted: nil, onDisposed: nil)
                let backItem = UIBarButtonItem(customView: leftBtn)
                self.navigationItem.leftBarButtonItem = backItem
                self.navigationController?.interactivePopGestureRecognizer?.delegate = self as! UIGestureRecognizerDelegate
        }
    }
    
    func fetchData()  {
        
        
    }
}





