//
//  SX_LoadingView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/10/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//  加载界面

import UIKit

class SX_LoadingView: UIView {

    typealias LoadingFailedBlock = (_ button: UIButton) -> Void
    
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

// ========================================================================================================================================
//  Other Method
// ========================================================================================================================================
extension SX_LoadingView  {
    
    func setUI() {
        self.backgroundColor = UIColor.colorWithHexString(hex: "f3f4f8", alpha: 1)
        self.indicatorView = UIImageView(frame: CGRect(x: SCREEN_WIDTH/2-418/4, y: SCREEN_HEIGHT/2-106/4-50, width: 418/2, height: 106/2))
        self.addSubview(self.indicatorView!)
    
        let imageArr = NSMutableArray()
        for index in 0...55 {
            let image = UIImage.init(named: "loadingView-\(index)")
            imageArr.add(image)
        }
        
        self.indicatorView?.animationImages = imageArr as! [UIImage]
        self.indicatorView?.animationDuration = 0.3 * Double(imageArr.count)
        self.indicatorView?.animationRepeatCount = 0
        indicatorView?.startAnimating()
        
        self.failView = UIImageView()
        
 
        
        
        
        
    }
}






