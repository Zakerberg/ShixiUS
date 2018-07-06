//
//  SX_BaseController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_BaseController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// 发送push通知
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /// 发送push通知
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setNavigationBarTitle(title:NSString) {
        self.navigationItem.title = title as String
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    func setlsftBackButton() {
        
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
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
