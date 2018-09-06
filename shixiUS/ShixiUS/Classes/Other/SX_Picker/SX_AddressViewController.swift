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
//        view.backOnClickCancel = {
//            self.onClickCancel()
//        }
//        /// 成功选择后将数据回调,并推出视图
//        view.backLocationString = { (address,province,city,area) in
//            if self.backLocationStringController != nil{
//                self.backLocationStringController!(address,province,city,area)
//                self.onClickCancel()
//            }
//        }
        return view
    }()
    
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
