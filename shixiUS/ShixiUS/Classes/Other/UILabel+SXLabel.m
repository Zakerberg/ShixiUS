//
//  UILabel+SXLabel.m
//  ShixiUS
//
//  Created by Michael 柏 on 7/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

#import "UILabel+SXLabel.h"

@implementation UILabel (SXLabel)

/**
 *  计算UILabel的高度(带有行间距的情况)
 *  @param text  内容
 *  @param font  字体
 *  @param width 宽度
 *  @return 高度
 *  @param zpace  字间距 --> @10 这样设置  默认的话设置 0 就ok
 */

-(CGFloat)SX_getSpaceLabelHeight:(NSString*)text withFont:(UIFont*)font withWidth:(CGFloat)width withSpace:(CGFloat)space withZspace:(NSNumber *)zpace{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode =NSLineBreakByCharWrapping;
    paraStyle.alignment =NSTextAlignmentLeft;
    paraStyle.lineSpacing = space;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent =0.0;
    paraStyle.paragraphSpacingBefore =0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    
    //设置字间距 NSKernAttributeName:@0.5f
    NSDictionary *dic;
    if (zpace == 0) {
        dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:@0.5f
               };
    }else {
        dic =@{NSFontAttributeName:font,NSParagraphStyleAttributeName:paraStyle,NSKernAttributeName:zpace
               };
    }
    
    CGSize size = [text boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

@end
