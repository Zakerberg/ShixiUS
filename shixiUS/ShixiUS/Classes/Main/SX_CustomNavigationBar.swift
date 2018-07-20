//
//  SX_CustomNavigationBar.swift
//  ShixiUS
//
//  Created by Michael 柏 on 7/19/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

fileprivate let SXDefaultTitleSize:CGFloat = 18
fileprivate let SXDefaultTitleColor = UIColor.black
fileprivate let SXDefaultBackgroundColor = UIColor.white

// =================================================================================================================================
// MARK: - 0123456789 -
// =================================================================================================================================
class SX_CustomNavigationBar: UIView {
    
    var onClickLeftBtn:(()->())?
    var onClickRightBtn:(()->())?
    
    var title: String? {
        willSet{
            titleLabel.isHidden = false
            titleLabel.text = newValue
        }
    }
    
    var titleLabelColor: UIColor? {
        willSet {
            titleLabel.textColor = newValue
        }
    }
    
    var titleLabelFont: UIFont? {
        willSet{
            titleLabel.font = newValue
        }
    }
    
    var barBackgroundColor: UIColor? {
        willSet{
            backgroundImageView.isHidden = true
            backgroundView.isHidden = false
            backgroundView.backgroundColor = newValue
        }
    }
    
    var barBackgroundImage: UIImage? {
        willSet{
            backgroundView.isHidden = true
            backgroundImageView.isHidden = false
            backgroundImageView.image = newValue
        }
    }
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = SXDefaultTitleColor
        label.font = UIFont.systemFont(ofSize: SXDefaultTitleSize)
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    fileprivate lazy var leftBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageView?.contentMode = .center
        btn.isHidden = true
        btn.addTarget(self, action: #selector(clickBack), for: .touchUpInside)
        return btn
    }()
    
    
    fileprivate lazy var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.imageView?.contentMode = .center
        btn.isHidden = true
        btn.addTarget(self, action: #selector(clickRight), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: (218.0/255.0), green: (218.0/255.0), blue: (218.0/255.0), alpha: 1.0)
        return view
    }()
    
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    
    fileprivate lazy var backgroundImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isHidden = true
        return imgView
    }()
    
    // fileprivate other variable
    fileprivate static var isIphoneX:Bool {
        get {
            return UIScreen.main.bounds.equalTo(CGRect(x: 0, y: 0, width: 375, height: 812))
        }
    }
    fileprivate static var navBarBottom:Int {
        get {
            return isIphoneX ? 88 : 64
        }
    }
    
    // init
    class func CustomNavigationBar() -> SX_CustomNavigationBar {
        let frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: CGFloat(navBarBottom))
        return SX_CustomNavigationBar(frame: frame)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView()
    {
        addSubview(backgroundView)
        addSubview(backgroundImageView)
        addSubview(leftBtn)
        addSubview(titleLabel)
        addSubview(rightBtn)
        addSubview(bottomLine)
        updateFrame()
        backgroundColor = UIColor.clear
        backgroundView.backgroundColor = SXDefaultBackgroundColor
    }
    func updateFrame()
    {
        let top:CGFloat = SX_CustomNavigationBar.isIphoneX ? 44 : 20
        let margin:CGFloat = 0
        let buttonHeight:CGFloat = 44
        let buttonWidth:CGFloat = 44
        let titleLabelHeight:CGFloat = 44
        let titleLabelWidth:CGFloat = 180
        
        backgroundView.frame = self.bounds
        backgroundImageView.frame = self.bounds
        leftBtn.frame = CGRect(x: margin, y: top, width: buttonWidth, height: buttonHeight)
        rightBtn.frame = CGRect(x: SCREEN_WIDTH-buttonWidth-margin, y: top, width: buttonWidth, height: buttonHeight)
        titleLabel.frame = CGRect(x: (SCREEN_WIDTH-titleLabelWidth)/2.0, y: top, width: titleLabelWidth, height: titleLabelHeight)
        bottomLine.frame = CGRect(x: 0, y: bounds.height-0.5, width: SCREEN_WIDTH, height: 0.5)
    }
}

// =================================================================================================================================
// MARK: - Router
// =================================================================================================================================
extension UIViewController {
    
    // A 页面  弹出登陆页面 B
    // presentedViewController  : A
    // presentingViewController : B
    
    func sx_toLastViewController(animated: Bool) {
        
        if self.navigationController != nil {
            
            if self.navigationController?.viewControllers.count == 1 {
                
                self.dismiss(animated: animated, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: animated)
            }
        } else if self.presentationController != nil {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
    class func sx_currentViewController() -> UIViewController {
        
        if let rootVC = UIApplication.shared.delegate?.window??.rootViewController {
            return self.sx_currentViewController(from: rootVC)
        }else {
            return UIViewController()
        }
        
    }
    
    class func sx_currentViewController(from fromVC:UIViewController) -> UIViewController {
        
        if fromVC.isKind(of: UINavigationController.self) {
            let navigationController = fromVC as! UINavigationController
            return sx_currentViewController(from: navigationController.viewControllers.last!)
        } else if fromVC.isKind(of: UITabBarController.self) {
            let tabBarController = fromVC as! UITabBarController
            return sx_currentViewController(from: tabBarController.selectedViewController!)
        } else if fromVC.presentationController != nil {
            return sx_currentViewController(from: fromVC.presentingViewController!)
        } else {
            return fromVC
        }
    }
}

extension SX_CustomNavigationBar {
    
    func sx_setBottomLineHidden(hidden:Bool) {
        bottomLine.isHidden = hidden
    }
    func sx_setBackgroundAlpha(alpha:CGFloat) {
        backgroundView.alpha = alpha
        backgroundImageView.alpha = alpha
        bottomLine.alpha = alpha
    }
    func sx_setTintColor(color:UIColor) {
        leftBtn.setTitleColor(color, for: .normal)
        rightBtn.setTitleColor(color, for: .normal)
        titleLabel.textColor = color
    }
    
    // 左右按钮共有方法
    func sx_setLeftButton(normal:UIImage, highlighted:UIImage) {
        sx_setLeftButton(normal: normal, highlighted: highlighted, title: nil, titleColor: nil)
    }
    func sx_setLeftButton(image:UIImage) {
        sx_setLeftButton(normal: image, highlighted: image, title: nil, titleColor: nil)
    }
    func sx_setLeftButton(title:String, titleColor:UIColor) {
        sx_setLeftButton(normal: nil, highlighted: nil, title: title, titleColor: titleColor)
    }
    
    func sx_setRightButton(normal:UIImage, highlighted:UIImage) {
        sx_setRightButton(normal: normal, highlighted: highlighted, title: nil, titleColor: nil)
    }
    func sx_setRightButton(image:UIImage) {
        sx_setRightButton(normal: image, highlighted: image, title: nil, titleColor: nil)
    }
    func sx_setRightButton(title:String, titleColor:UIColor) {
        sx_setRightButton(normal: nil, highlighted: nil, title: title, titleColor: titleColor)
    }
    
    
    // 左右按钮私有方法
    private func sx_setLeftButton(normal:UIImage?, highlighted:UIImage?, title:String?, titleColor:UIColor?) {
        leftBtn.isHidden = false
        leftBtn.setImage(normal, for: .normal)
        leftBtn.setImage(highlighted, for: .highlighted)
        leftBtn.setTitle(title, for: .normal)
        leftBtn.setTitleColor(titleColor, for: .normal)
    }
    private func sx_setRightButton(normal:UIImage?, highlighted:UIImage?, title:String?, titleColor:UIColor?) {
        rightBtn.isHidden = false
        rightBtn.setImage(normal, for: .normal)
        rightBtn.setImage(highlighted, for: .highlighted)
        rightBtn.setTitle(title, for: .normal)
        rightBtn.setTitleColor(titleColor, for: .normal)
    }
}


// =================================================================================================================================
// MARK: - Othrt Method 响应
// =================================================================================================================================
extension SX_CustomNavigationBar {
    
    @objc func clickBack() {
        if let onClickBack = onClickLeftBtn {
            onClickBack()
        } else {
            let currentVC = UIViewController.sx_currentViewController()
            currentVC.sx_toLastViewController(animated: true)
        }
    }
    
    @objc func clickRight() {
        if let onClickRight = onClickRightBtn {
            onClickRight()
        }
    }
}









