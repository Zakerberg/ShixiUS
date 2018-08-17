//
//  SX_UserAgreementController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/17/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  实习网用户协议

import UIKit
import WebKit

class SX_UserAgreementController: UIViewController,WKNavigationDelegate {

    var webView : WKWebView?
    var urlStr  : NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWebView()
        setLeftBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===========================================================================================================================
// MARK: - Other Method
// ===========================================================================================================================
extension SX_UserAgreementController {
    
    func setUpWebView() {
        self.view.backgroundColor = UIColor.colorWithHexString(hex: "cccccc", alpha: 1)
        let config   = WKWebViewConfiguration()
        self.webView = WKWebView(frame: CGRect(x: 0, y: -45.FloatValue.IPAD_XValue, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: config)
        self.webView?.navigationDelegate = self
        let request = NSURLRequest(url: URL(string: "2222")!)
        self.webView?.load(request as URLRequest)
        
        self.view.addSubview(self.webView!)
    }
    
    func setLeftBackButton() {
    
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 10.FloatValue.IPAD_XValue, y: 30.FloatValue.IPAD_XValue, width: 22.FloatValue.IPAD_XValue, height: 22.FloatValue.IPAD_XValue)
        leftBtn.setImage(UIImage.init(named: "button_back"), for: .normal)
        
        leftBtn.rx.tap.subscribe(onNext: { (_) in
        self.dismiss(animated: true, completion: nil)
        }, onError: { (error) in
            SXLog(error)
        }, onCompleted: nil, onDisposed: nil)
        
        webView?.addSubview(leftBtn)
    }
}
