//
//  UILabel+SXLabel.h
//  ShixiUS
//
//  Created by Michael 柏 on 7/25/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SXLabel)
/**
 *  计算UILabel的高度(带有行间距的情况)
 *  @param text  内容
 *  @param font  字体
 *  @param width 宽度
 *  @return 高度
 *  @param zpace  字间距 --> @10 这样设置  默认的话设置 0 就ok
 */
-(CGFloat)SX_getSpaceLabelHeight:(NSString*)text withFont:(UIFont*)font withWidth:(CGFloat)width withSpace:(CGFloat)space withZspace:(NSNumber *)zpace;

@end
