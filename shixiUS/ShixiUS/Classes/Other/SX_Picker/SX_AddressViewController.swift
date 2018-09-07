//
//  SX_AddressViewController.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/6.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 我不是兵马俑，守不了秦皇陵
 我不是杜牧之，道不尽阿房宫
 我只是你的人，只得你一人心
 */

import UIKit

class SX_AddressViewController: UIViewController {
    
    var backLocationStringController: ((String,String,String,String)->())?
    
    lazy var containV: SX_AddressPickerView = {
        let view = SX_AddressPickerView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-550, width: SCREEN_WIDTH, height: 550))
        view.backOnClickCancel = {
            self.onClickCancel()
        }
        /// 成功选择后将数据回调,并推出视图
        view.backLocationString = { (address,province,city,area) in
            if self.backLocationStringController != nil{
                self.backLocationStringController!(address,province,city,area)
                self.onClickCancel()
            }
        }
        return view
    }()
    
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// ===================================================================================================================
// MARK: - Other Method
// ===================================================================================================================
extension SX_AddressViewController {
    
    func drawMyView() {
        self.view.insertSubview(self.backgroundView, at: 0)
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = .custom//viewcontroller弹出后之前控制器页面不隐藏 .custom代表自定义
        self.view.addSubview(self.containV)
        // 转场动画代理
        self.transitioningDelegate = self
    }
    
    ///点击推出
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: onClick
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

// ===================================================================================================================
// MARK: - UIViewControllerTransitioningDelegate
// ===================================================================================================================
extension SX_AddressViewController: UIViewControllerTransitioningDelegate {
    /// 推入动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = SX_AddressPickerPresentAnimated(type: .present)
        
        return animated
    }
    /// 推出动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = SX_AddressPickerPresentAnimated(type: .dismiss)
        
        return animated
    }
}
