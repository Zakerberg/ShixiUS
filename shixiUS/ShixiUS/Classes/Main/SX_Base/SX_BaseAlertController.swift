//
//  SX_BaseAlertController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/28.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 《破阵子》
 
 人生不过三天
 去今往来何年
 不为红颜眉一笑
 此生何必作仙凡
 一朝醉万年
 
 逍遥天外飞仙
 蓬莱此去东南
 灵鹤送我真情录
 薄毡不解月夜寒
 为伊又难眠
 */

import UIKit

let AlertWidth: CGFloat   = 330.FloatValue.IPAD_XValue
let AlertHeight:CGFloat   = 130.FloatValue.IPAD_XValue

let AlertPadding: CGFloat = 10
let MenuHeight: CGFloat   = 44

enum ButtonType {
    case OK, Cancel, Other
}

class SX_AlertDialogItem: NSObject {
    var title:String?
    var type:ButtonType?
    var tag:NSInteger?
    var action:((_ item:SX_AlertDialogItem) -> Void)?
}

class SX_BaseAlertController: UIView {
    
    var coverView:UIView?
    var alertView:UIView?
    var labelTitle:UILabel?
    var labelmessage:UILabel?
    
    var buttonScrollView:UIScrollView?
    var contentScrollView:UIScrollView?
    
    var items:NSMutableArray?
    var title:String?
    var message:String?
    
    var buttonWidth:CGFloat?
    var contentView:UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 便利构造函数
    convenience init(title:String, message:String, messageColor:UIColor?) {
        
        // 计算frame
        var SCREENWIDTH  = UIScreen.main.bounds.size.width
        var SCREENHEIGHT = UIScreen.main.bounds.size.height
        
//        if floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1 {
//            let interfaceOrientation = UIApplication.shared.statusBarOrientation
//            if UIInterfaceOrientationIsLandscape(interfaceOrientation) {
                let tmp      = SCREENWIDTH
                SCREENWIDTH  = SCREENHEIGHT
                SCREENHEIGHT = tmp
//            }
//        }
        let rect     = CGRect(x: 0, y: 0, width: SCREENWIDTH, height: SCREENHEIGHT)
        
        self.init(frame: rect)
        self.items   = NSMutableArray()
        self.title   = title
        self.message = message
        
        // 设置views
        self.buildViews(messageColor)
    }
    
    func buildViews(_ color:UIColor?) {
        self.coverView                      = UIView(frame: self.topView().bounds)
        self.coverView?.backgroundColor     = UIColor.black
        self.coverView?.alpha               = 0
        self.coverView?.autoresizingMask    = UIViewAutoresizing.flexibleHeight
        self.topView().addSubview(self.coverView!)
        
        self.alertView = UIView(frame: CGRect(x: 0, y: 0, width: AlertWidth, height: AlertHeight))
        self.alertView?.center              = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.alertView?.layer.masksToBounds = true
        self.alertView?.layer.cornerRadius  = 5
        self.alertView?.backgroundColor     = UIColor.white
        
        self.addSubview(self.alertView!)
        
        // 设置title
//        let labelHeigh = self.heighOfRow(self.title! as NSString, font: 17, width: AlertWidth - 2 * AlertPadding)
//        self.labelTitle = UILabel(frame: CGRect(x: AlertPadding, y: AlertPadding, width: AlertWidth - 2 * AlertPadding, height: labelHeigh))
        
        self.labelTitle = UILabel().addhere(toSuperView: self.alertView!).layout(snapKitMaker: { (make) in
            make.top.equalToSuperview().offset(Margin)
            make.width.equalToSuperview()
            make.height.equalTo(25.FloatValue.IPAD_XValue)
        }).config({ (LABELTITLE) in
            LABELTITLE.font          = UIFont.boldSystemFont(ofSize: 17)
            LABELTITLE.textColor     = UIColor.black
            LABELTITLE.textAlignment = NSTextAlignment.center
            LABELTITLE.text          = self.title
        })
        
//        self.labelTitle?.font          = UIFont.boldSystemFont(ofSize: 17)
//        self.labelTitle?.textColor     = UIColor.black
//        self.labelTitle?.textAlignment = NSTextAlignment.center
//        self.labelTitle?.numberOfLines = 0
//        self.labelTitle?.text          = self.title
//        self.labelTitle?.lineBreakMode = NSLineBreakMode.byCharWrapping
//        self.alertView?.addSubview(self.labelTitle!)
        
        // 设置message
//        let messageHeigh  = self.heighOfRow(self.message! as NSString, font: 14, width: AlertWidth - 2 * AlertPadding)
//        self.labelmessage = UILabel(frame: CGRect(x: AlertPadding, y: self.labelTitle!.frame.origin.y + self.labelTitle!.frame.size.height, width: AlertWidth - 2 * AlertPadding, height: messageHeigh + 2 * AlertPadding))
//        self.labelmessage?.font = UIFont.systemFont(ofSize: 14)
//
//        let mesColor:UIColor             = color ?? UIColor.black
//        self.labelmessage?.textColor     = mesColor
//        self.labelmessage?.textAlignment = NSTextAlignment.center
//        self.labelmessage?.text          = self.message
//        self.labelmessage?.numberOfLines = 0
//        self.labelmessage?.lineBreakMode = NSLineBreakMode.byCharWrapping
//        self.alertView?.addSubview(self.labelmessage!)
//
//        self.contentScrollView = UIScrollView(frame: CGRect.zero)
//        self.alertView?.addSubview(self.contentScrollView!)
//
//        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
//        NotificationCenter.default.addObserver(self, selector: #selector(SX_BaseAlertController.deviceOrientationDidChange(_:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

    }
    
    // override func
//    override func layoutSubviews() {
//        self.buttonScrollView?.frame  = CGRect(x: 0, y: self.alertView!.frame.size.height-MenuHeight,width: self.alertView!.frame.size.width, height: MenuHeight);
//        self.contentScrollView?.frame = CGRect(x: 0, y: self.labelTitle!.frame.origin.y + self.labelTitle!.frame.size.height, width: self.alertView!.frame.size.width, height: self.alertView!.frame.size.height - MenuHeight);
//        self.contentView?.frame       = CGRect(x: 0,y: 0,width: self.contentView!.frame.size.width, height: self.contentView!.frame.size.height);
//        if self.contentView != nil {
//            self.contentScrollView?.contentSize = self.contentView!.frame.size;
//        }
//    }
    
//    override func willMove(toSuperview newSuperview: UIView?) {
//        self.addButtonItem()
//        if self.contentView != nil {
//            self.contentScrollView?.addSubview(self.contentView!)
//        }
//        self.reLayout()
//    }
    
    // show and dismiss
    func topView() -> UIView {
        let window = UIApplication.shared.keyWindow
        return (window?.subviews[0])!
    }
    
    //------Preoperties------
    func addButtonWithTitle(_ title:String) -> NSInteger {
        let item = SX_AlertDialogItem()
        item.title = title
        item.action = {(ite:SX_AlertDialogItem)->Void in
            print("no action")
        }
        item.type = ButtonType.OK
        self.items?.add(item)
        return (self.items?.index(of: title))!
    }
    
    func addButton(_ type:ButtonType, title:String, handler:@escaping ((_ item:SX_AlertDialogItem) -> Void)) {
        let item = SX_AlertDialogItem()
        item.title = title
        item.action = handler
        item.type = type
        self.items?.add(item)
        
        item.tag = self.items?.index(of: item)
    }
    
    func addButtonItem() {
        self.buttonScrollView = UIScrollView(frame: CGRect(x: 0, y: self.alertView!.frame.size.height -  MenuHeight,width: AlertWidth, height: MenuHeight))
        self.buttonScrollView?.bounces = false
        self.buttonScrollView?.showsHorizontalScrollIndicator = false
        self.buttonScrollView?.showsVerticalScrollIndicator = false
        let width:CGFloat
        if (self.buttonWidth != nil) {
            width = self.buttonWidth!
            let a = CGFloat((self.items?.count)!)
            self.buttonScrollView?.contentSize = CGSize(width: a * width, height: MenuHeight)
        }else {
            width = (self.alertView?.frame.size.width)! / CGFloat((self.items?.count)!)
        }
        
        self.items?.enumerateObjects({ (item, idx, stop) in
            let button   = UIButton(type: UIButtonType.system)
            button.frame = CGRect(x: CGFloat(idx) * width, y: 1, width: width, height: MenuHeight)
            button.backgroundColor     = UIColor.white
            button.layer.shadowColor   = UIColor.colorWithHexString(hex: "333333", alpha: 0.1).cgColor
            button.layer.shadowRadius  = 0.5
            button.layer.shadowOpacity = 1
            button.layer.shadowOffset  = CGSize.zero
            button.layer.masksToBounds = false
            button.tag                 = 90000 + idx
            
            let ite = item as! SX_AlertDialogItem
            
            button.setTitle(ite.title, for: .selected)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: (button.titleLabel?.font.pointSize)!)
            
            button.addTarget(self, action: #selector(SX_BaseAlertController.buttonTouched(_:)), for: UIControlEvents.touchUpInside)
            self.buttonScrollView?.addSubview(button)
            
            // 按钮边框
            if idx != (self.items?.count)! - 1 {
                let seprateLineVer = UIView(frame: CGRect(x: width - 1, y: 0, width: 2, height: MenuHeight))
                seprateLineVer.backgroundColor = UIColor.colorWithHexString(hex: "333333", alpha: 0.1)
                button.addSubview(seprateLineVer)
            }
            
            let seprateLineHor = UIView(frame: CGRect(x: 0, y: 0, width: self.buttonScrollView!.frame.size.width, height: 1))
            seprateLineHor.backgroundColor = UIColor.colorWithHexString(hex: "333333", alpha: 0.1)
            self.buttonScrollView?.addSubview(seprateLineHor)
        })
        self.alertView?.addSubview(self.buttonScrollView!)
    }
    
//    func reLayout() {
//        var plus:CGFloat
//        if self.contentView != nil {
//            plus = (self.contentView!.frame.size.height) - ((self.alertView?.frame.size.height)! - MenuHeight)
//        }else {
//            plus = (self.labelmessage?.frame.origin.y)! + (self.labelmessage?.frame.size.height)! - ((self.alertView?.frame.size.height)! - MenuHeight)
//        }
//        plus = max(0, plus)
//        let height = min(self.screenBounds().size.height - MenuHeight, (self.alertView?.frame.size.height)! + plus)
//
//        self.alertView?.frame  = CGRect(x: self.alertView!.frame.origin.x, y: self.alertView!.frame.origin.y, width: AlertWidth, height: height)
//        self.alertView?.center = self.center
//        self.setNeedsDisplay()
//        self.setNeedsLayout()
//    }
}

//=======================================================================================
// MARK: - 计算frame
//=======================================================================================
extension SX_BaseAlertController {
    
    // 计算frame
    func screenBounds() -> CGRect {
        var screenWidth  = UIScreen.main.bounds.size.width
        var screenHeight = UIScreen.main.bounds.size.height
        // On iOS7, screen width and height doesn't automatically follow orientation
        if floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1 {
            let interfaceOrientation = UIApplication.shared.statusBarOrientation
            if UIInterfaceOrientationIsLandscape(interfaceOrientation) {
                let tmp = screenWidth
                screenWidth = screenHeight
                screenHeight = tmp
            }
        }
        
        return CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    }
    
    // 计算字符串高度
    func heighOfRow(_ text:NSString, font:CGFloat, width:CGFloat) -> CGFloat {
        let wSize:CGSize = text.boundingRect(with: CGSize(width: width, height: 0), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: font)], context: nil).size
        
        return wSize.height;
    }
}

//=======================================================================================
// MARK: - @objc
//=======================================================================================
extension SX_BaseAlertController {
    
    @objc func buttonTouched(_ button:UIButton) {
        let item:SX_AlertDialogItem = self.items![button.tag - 90000] as! SX_AlertDialogItem
        if (item.action != nil) {
            item.action!(item)
        }
        self.dismiss()
    }
    
    @objc func deviceOrientationDidChange(_ notification:Notification) {
        self.frame = self.screenBounds()
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
//            self.reLayout()
        }) { (finished) -> Void in
         
            
            
        }
    }
}


//=======================================================================================
// MARK: - show, hide, dismiss
//=======================================================================================
extension SX_BaseAlertController {
    
    func showAnimation() {
        let popAnimation      = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.4
        popAnimation.values   = [
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.01, 0.01, 1.0)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(1.1, 1.1, 1.0)),
            NSValue.init(caTransform3D: CATransform3DMakeScale(0.9, 0.9, 1.0)),
            NSValue.init(caTransform3D: CATransform3DIdentity)
        ]
        popAnimation.keyTimes = [0.2, 0.5, 0.75, 1.0]
        popAnimation.timingFunctions = [
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut),
            CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        ]
        self.alertView?.layer.add(popAnimation, forKey: nil)
    }
    
    func hideAnimation() {
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.coverView?.alpha = 0.0
            self.alertView?.alpha = 0.0
        }, completion: { (finished) -> Void in
            self.removeFromSuperview()
        })
    }
    
    func show() {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.coverView?.alpha = 0.5
        }, completion: { (finished) -> Void in
            
        })
        self.topView().addSubview(self)
        self.showAnimation()
    }
    
    func dismiss() {
        self.hideAnimation()
    }
}
