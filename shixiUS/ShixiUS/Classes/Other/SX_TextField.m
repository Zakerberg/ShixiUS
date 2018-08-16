//
//  SX_TextField.m
//  ShixiUS
//
//  Created by Michael 柏 on 8/16/18.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

#import "SX_TextField.h"

@implementation SX_TextField

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 0);
}

@end
