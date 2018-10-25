//
//  SX_BaseController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/10/25.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_BaseController: UIViewController {
    
    var loadingView: SX_LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoadingView() {
        if (!(self.loadingView != nil)) {
            self.loadingView = SX_LoadingView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        }
        self.view.addSubview(self.loadingView!)
    }
    
    func hideLoadingView() {
        let delaySeconds = UInt64(0.5)
        let popTime = NSEC_PER_SEC*delaySeconds
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: popTime), execute: {
            self.loadingView?.hideLoadingView()
            self.loadingView = nil
        })
    }
}
