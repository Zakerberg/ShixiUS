//
//  SX_ProjectDetailFrameModel.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/9/4.
//  Copyright © 2018年 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
// 

/*
 你不曾体会我这般的失落
 别人说一向明媚的我
 怎么走丢了阳光
 */

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

    var model = SX_ProgressDetailModel() {
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

//            contentAttributedStr = NSMutableAttributedString()
            //  contentAttributedString.yy_font = CZHGlobelNormalFont(14);
            //  contentAttributedString.yy_color = _contentColor;
            //  contentAttributedString.yy_lineSpacing = 10;
        
            ///计算控件frame
            let maxSize = CGSize(width: SCREEN_WIDTH-60.FloatValue.IPAD_XValue, height: CGFloat(MAXFLOAT))
  
//            let contentLayout =
            
            
        /*
             CGSize contentLabelSize = [YYTextLayout layoutWithContainerSize:maxSize text:_contentAttributedString].textBoundingSize;
             
             CGFloat contentLabelX = MARGIN_LEFT;
             CGFloat contentLabelY = CZH_ScaleWidth(15);
             CGFloat contentLabelW = contentLabelSize.width;
             CGFloat contentLabelH = contentLabelSize.height;
             _contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
             
             CGSize timeLabelSize = [_timeString czh_sizeWithFont:CZHGlobelNormalFont(11) maxW:MAX_WIDTH];
             CGFloat timeLabelX = MARGIN_LEFT;
             CGFloat timeLabelY = CGRectGetMaxY(_contentLabelF) + CZH_ScaleWidth(10);
             CGFloat timeLabelW = timeLabelSize.width;
             CGFloat timeLabelH = timeLabelSize.height;
             _timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelW, timeLabelH);
             
             CGFloat leftRoundViewX = 0;
             CGFloat leftRoundViewY = 0;
             CGFloat leftRoundViewW = 0;
             CGFloat leftRoundViewH = 0;
             
             if (model.indexCount == 0) {
             
             leftRoundViewY = CZH_ScaleWidth(15);
             leftRoundViewW = CZH_ScaleWidth(15);
             leftRoundViewH = CZH_ScaleWidth(15);
             
             } else {
             leftRoundViewY = CZH_ScaleWidth(19);
             leftRoundViewW = CZH_ScaleWidth(7);
             leftRoundViewH = CZH_ScaleWidth(7);
             
             }
             
             leftRoundViewX = (MARGIN_LEFT - leftRoundViewW) * 0.5;
             _leftRoundViewF = CGRectMake(leftRoundViewX, leftRoundViewY, leftRoundViewW, leftRoundViewH);
             _cellHeight = CGRectGetMaxY(_timeLabelF) + CZH_ScaleWidth(15);
             if (model.indexCount == model.totalCount - 1) {
             _bottomLineF = CGRectZero;
             } else {
             CGFloat bottomLineX = MARGIN_LEFT;
             CGFloat bottomLineY = _cellHeight - 0.5;
             CGFloat bottomLineW = ScreenWidth - bottomLineX;
             CGFloat bottomLineH = 0.5;
             _bottomLineF = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH);
             }
             
             CGFloat leftLineViewW = 1;
             CGFloat leftLineViewX = (MARGIN_LEFT - leftLineViewW) * 0.5;
             CGFloat leftLineViewY = 0;
             CGFloat leftLineViewH = 0;
             
             if (model.indexCount == 0) {//第一个
             leftLineViewY = CGRectGetMaxY(_leftRoundViewF);
             leftLineViewH = _cellHeight - leftLineViewY;
             } else if (model.indexCount == model.totalCount - 1) {//最后一个
             leftLineViewY = 0;
             leftLineViewH = CGRectGetMinY(_leftRoundViewF);
             } else {
             leftLineViewY = 0;
             leftLineViewH = _cellHeight;
             }
             _leftLineViewF = CGRectMake(leftLineViewX, leftLineViewY, leftLineViewW, leftLineViewH);
             
             */
        
        }
    }
}
