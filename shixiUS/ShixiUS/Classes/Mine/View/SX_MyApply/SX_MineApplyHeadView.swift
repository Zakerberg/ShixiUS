//
//  SX_MineApplyHeadView.swift
//  ShixiUS
//
//  Created by Michael 柏 on 8/7/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

/*
 
 北上看到的冰川是你
 南下追寻的极光是你
 西去流浪的经幡是你
 东去皈依的佛经也是你
 世不遇你
 生无可喜

 */

import UIKit

class SX_MineApplyHeadView: UIView {
    
    typealias translateButtonTag = ((_ tag: NSInteger) -> Void)
    
    var titleBtn: UIButton?
    var translateButtonTag: translateButtonTag?
    
    var _titleScrollView: UIScrollView?
    var _lastSelectedButton: UIButton?
    var _SelectedImageView: UIImageView?
    var _badgeLabel: UILabel?
    var _badgeValue: NSString?
    var _isShow : Bool?
    var _isShow2: Bool?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        _isShow = true
        _isShow2 = true
        creatTheHeadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// ===============================================================================================================================
// MARK: - Other Method
// ===============================================================================================================================
extension SX_MineApplyHeadView {
    
    func creatTheHeadView() {
        let titleArr = ["就业岗位", "实训项目", "职业培训"]
        let buttonWidth = SCREEN_WIDTH/3
        
        _titleScrollView = UIScrollView().addhere(toSuperView: self).layout(snapKitMaker: { (make) in
            
        }).config({ (titleScrollView) in
            
        })
    }
    
    func titleButtonAction(button: UIButton) {
        
        if button.tag == 1001 {
         
            /*
             
             if (button.tag == 1001) {
             _redPointView2.hidden = YES;
             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
             NSString *urlString = [NSString stringWithFormat:@"%@/mark/status=%d?token=%@&user_id=%@",[Request_Url URL_ResumeMessage],2,[defaults objectForKey:@"token"],[defaults objectForKey:@"userId"]];
             [NetManager requestDataWithUrlString:urlString contentType:nil finished:^(id responseObj) {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableContainers error:nil];
             if ([dic[@"result_code"] isEqual:@1]) {
             [[NSNotificationCenter defaultCenter] postNotificationName:GetRedViewCount object:nil];
             }
             } failed:^(NSString *errorMsg) {
             }];
             }
             */
            
        }
    }
    
    // 列表View滑动时, 获得滑动手ScrollView
    func listScrollViewDidScroll(scrollView: UIScrollView) {
        SXLog("偏移量=====\(scrollView.contentOffset.x)")
        let page = scrollView.contentOffset.x
        SXLog("当前的滑动页-----\(page)")
        
        let nowButton = self.viewWithTag(Int(1000 + page)) as? UIButton
        titleButtonAction(button: nowButton!)
    }
}

