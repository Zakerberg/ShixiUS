//
//  SX_AddressPickerPresentAnimated.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
// 

/*
 音乐休止，电影剧终
 你在我身边，开始到未来
 我写了很长的故事，是一辈子的时间
 */

import UIKit

enum SXAddressPickerPresentAnimateType {
    case present //被推出时
    case dismiss //取消时
}

class SX_AddressPickerPresentAnimated: NSObject,UIViewControllerAnimatedTransitioning {
    
    var type: SXAddressPickerPresentAnimateType = .present
    
    init(type: SXAddressPickerPresentAnimateType) {
        self.type = type
    }
    
    /// 动画时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    /// 动画效果
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch type {
        case .present:
            let toVC : SX_AddressViewController = transitionContext.viewController(forKey: .to) as! SX_AddressViewController
            let toView = toVC.view
            
            let containerView = transitionContext.containerView
            containerView.addSubview(toView!)
            toVC.containV.transform = CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))
        
            UIView.animate(withDuration: 0.25, animations: {
                /// 背景变色
                toVC.backgroundView.alpha = 1.0
                /// addresspicker向上推出
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: -10)
            }) { (finished) in
                UIView.animate(withDuration: 0.2, animations: {
                    /// transform初始化
                    toVC.containV.transform = CGAffineTransform.identity
                }, completion: { (finished) in
                    transitionContext.completeTransition(true)
                })
            }
            
        case .dismiss:
            let toVC : SX_AddressViewController = transitionContext.viewController(forKey: .from) as! SX_AddressViewController
    
            UIView.animate(withDuration: 0.25, animations: {
                toVC.backgroundView.alpha = 0.0
                /// addresspicker向下推回
                toVC.containV.transform =  CGAffineTransform(translationX: 0, y: (toVC.containV.frame.height))
            }) { (finished) in
                transitionContext.completeTransition(true)
            }
        }
    }
}
