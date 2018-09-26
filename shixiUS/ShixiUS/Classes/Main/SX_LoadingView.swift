//
//  SX_LoadingView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  加载界面

/*
 我以前不写情诗
 怕每一次动笔之时
 想你想得神智不清
 */

import UIKit

class SX_LoadingView: UIView {
    
    typealias LoadingFailClosure = ((_ btn: UIButton)->())
    
    var loadingFailedBClosure: LoadingFailClosure?
    var indicatorView: UIImageView?
    var failIndicatorLabel: UILabel?
    var failView: UIImageView?
    var failLabel: UILabel?
    var reloadButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// =======================================================================================
//  Other Method
// ========================================================================================
extension SX_LoadingView  {
    
    func setUI() {
        self.backgroundColor = UIColor.colorWithHexString(hex: "f3f4f8", alpha: 1)
        self.indicatorView = UIImageView(frame: CGRect(x: SCREEN_WIDTH/2-418/4, y: SCREEN_HEIGHT/2-106/4-50, width: 418/2, height: 106/2))
        self.addSubview(self.indicatorView!)
        
        let imageArr = NSMutableArray()
        for index in 0..<54 {
            let image = UIImage.init(named: "loadingView-\(index)")
            imageArr.add(image!)
        }
        
        self.indicatorView?.animationImages = imageArr as? [UIImage]
        self.indicatorView?.animationDuration = 0.3 * Double(imageArr.count)
        self.indicatorView?.animationRepeatCount = 0
        indicatorView?.startAnimating()
        
        self.failView?.frame = CGRect(x: SCREEN_WIDTH/2-100/4, y: SCREEN_HEIGHT/2-71/2-50-20, width: 50, height: 71/2)
        self.failView = UIImageView(image: UIImage.init(named: "icon_wifi")).addhere(toSuperView: self).config({ (failView) in
            failView.alpha = 0
        })
        
        self.failLabel = UILabel().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.failView!.snp.bottom).offset(20)
        }).config({ (failLabel) in
            failLabel.text = "界面加载失败"
            failLabel.numberOfLines = 2
            failLabel.font = UIFont.systemFont(ofSize: 13)
            failLabel.alpha = 0
            failLabel.textAlignment = .center
            failLabel.textColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
        })
        
        self.reloadButton = UIButton(type: .custom).addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            make.top.equalTo(self.failLabel!.snp.bottom).offset(23)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 90, height: 28))
        }).config({ (reloadButton) in
            reloadButton.setTitle("重新加载", for: .normal)
            reloadButton.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            reloadButton.layer.borderWidth = 0.5
            reloadButton.layer.cornerRadius = 3
            reloadButton.layer.borderColor = UIColor.colorWithHexString(hex: "999999", alpha: 1).cgColor
            
            reloadButton.alpha = 0
            reloadButton.setTitleColor(UIColor.colorWithHexString(hex: "666666", alpha: 1), for: .normal)
            reloadButton.addTarget(self, action: #selector(reloadButtonClick), for: .touchUpInside)
        })
    }
    
    /// hideLoadingView
    func hideLoadingView() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
    /// loadingFailed
    func loadingFail() {
        self.indicatorView?.alpha = 0
        self.failLabel?.alpha = 1
        self.failView?.alpha = 1
        self.reloadButton?.alpha = 1
    }
    
    ///
    @objc func reloadButtonClick(btn: UIButton) {
        if self.loadingFailedBClosure != nil {
            self.loadingFailedBClosure!(btn)
        }
        
        self.indicatorView?.startAnimating()
        self.failView?.alpha = 0
        self.failLabel?.alpha = 0
        self.reloadButton?.alpha = 0
    }
}
