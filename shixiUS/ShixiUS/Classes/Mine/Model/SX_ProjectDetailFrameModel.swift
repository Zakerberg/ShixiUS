//
//  SX_ProjectDetailFrameModel.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/4.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class SX_ProjectDetailFrameModel: NSObject {
    
    var leftRoundImageView: UIImageView?
    var leftLineView: UIView?
    var progressTitle: UILabel?
    var contentLabel: UILabel?
    var bottomLine: UIView?
    
    /// 文本
    var contentString: NSString?
    /// 内容富文本
    var contentAttributedStr: NSMutableAttributedString?
    /// 文本颜色
    var contentColor: UIColor?
    /// 进度title颜色
    var progressTitleColor: UIColor?
    /// cell高度
    var cellHeight: CGFloat?
    
    var model: SX_ProgressDetailModel {
        didSet{
            ///判断颜色
            if model.indexCount == 0 {
                progressTitleColor = UIColor.colorWithHexString(hex: "333333", alpha: 1)
                contentColor = UIColor.colorWithHexString(hex: "72a216", alpha: 1)
                leftRoundImageView?.image = UIImage.init(named: "progress")
            }else{
                progressTitleColor = UIColor.colorWithHexString(hex: "666666", alpha: 1)
                contentColor = UIColor.colorWithHexString(hex: "999999", alpha: 1)
                leftRoundImageView?.image = UIImage.init(named: "progress1")
            }
            
            contentAttributedStr = NSMutableAttributedString()
            //  contentAttributedString.yy_font = CZHGlobelNormalFont(14);
            //  contentAttributedString.yy_color = _contentColor;
            //  contentAttributedString.yy_lineSpacing = 10;
            
  
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        }
    }
}
