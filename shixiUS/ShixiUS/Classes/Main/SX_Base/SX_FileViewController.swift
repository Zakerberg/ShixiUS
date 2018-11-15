//
//  SX_FileViewController.swift
//  ShixiUS
//
//  Created by heather on 2018/11/15.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_FileViewController: SX_BaseController {
    
    var webView: UIWebView?
    var uploadBtn: UIButton?
    var decomentController: UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        showLoadingView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ==============================================================
// MARK: - Other Method
// ==============================================================
extension SX_FileViewController {
    
    func setUI() {
        title = "个人简历"
        self.view.backgroundColor = UIColor.SX_BackGroundColor()
        
        self.webView = UIWebView().addhere(toSuperView: self.view).layout(snapKitMaker: { (make) in
            
        }).config({ (WEBVIEW) in
            
        })
    }
    
    func fetchData() {
        hideLoadingView()
    }
}

// ==============================================================
// MARK: -
// ==============================================================
extension SX_FileViewController {
    
    func openDocumentInResourceFolder() {
    
        
        
        
    }
}

// ==============================================================
// MARK: - Other Method
// ==============================================================
extension SX_FileViewController: UIDocumentInteractionControllerDelegate {
    
    func documentInteractionControllerWillBeginPreview(_ controller: UIDocumentInteractionController) {
        
    }
    
    func documentInteractionControllerDidEndPreview(_ controller: UIDocumentInteractionController) {
        
    }
    
    func documentInteractionControllerDidDismissOpenInMenu(_ controller: UIDocumentInteractionController) {
        
    }
}

