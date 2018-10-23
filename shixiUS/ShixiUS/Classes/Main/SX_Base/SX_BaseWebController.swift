//
//  SX_BaseWebController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/6/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我以后还会写情诗
 因为我始终还在相信
 我的诗会有你读完的那一天
 */

import UIKit
import WebKit

class SX_BaseWebController: UIViewController {
    
    var webView: WKWebView?
    var webURL: NSString?
    var loadingView:SX_LoadingView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setWebView()
        loadWebView()
        setLeftBack()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ======================================================================
// MARK: - Other Method
// ======================================================================
extension SX_BaseWebController {
    
    func setWebView() {
        let con = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect(x: 0, y: -kNavH, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), configuration: con).addhere(toSuperView: self.view).config({ (WEB) in
            WEB.navigationDelegate = self
        })
    }
    
    func loadWebView() {
        
    }
    
    func setLeftBack() {
       
        /*
         UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
         btn.frame = CGRectMake(0, 0, 44, 44);
         [btn setImage:[UIImage imageNamed:@"button_back_home"] forState:UIControlStateNormal];
         [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
         btn.imageEdgeInsets = UIEdgeInsetsMake(0, -28, 0, 0);
         UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
         self.navigationItem.leftBarButtonItem = backItem;
         self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
         */
    }
}

// ======================================================================
// MARK: - WKNavigationDelegate
// ======================================================================
extension SX_BaseWebController: WKNavigationDelegate {
    //开始的代理里添加hud
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SXLog(#function)
        if !(self.loadingView != nil) {
            loadingView = SX_LoadingView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        }
        self.view.addSubview(loadingView!)
    }
    
    ///失败或者加载完成添加hud的隐藏 开始展示就隐藏hud
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        /*
         double delaySeconds = 0.5;
         __weak BaseViewController *weakSelf = self;
         dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delaySeconds * NSEC_PER_SEC));
         dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
         [weakSelf.loadingView hideLoadingView];
         weakSelf.loadingView = nil;
         });
         NSLog(@"%s",__FUNCTION__);
         */
    }
}


// ======================================================================
// MARK: - UIWebViewDelegate
// ======================================================================
extension SX_BaseWebController: UIWebViewDelegate {
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
}
