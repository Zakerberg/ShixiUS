//
//  NSDictionary+SXArray.m
//  ShixiUS
//
//  Created by heather on 2018/10/23.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

#import "NSDictionary+SXArray.h"

@implementation NSDictionary (SXArray)
- (NSString *)description {
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    [strM appendString:@"}"];
    if (self.allKeys.count > 0) {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }
    return strM;
}
@end


@implementation NSArray (SXArray)

- (NSString *)description {
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")\n"];
    if (self.count > 0) {
        NSRange range = [strM rangeOfString:@"," options:NSBackwardsSearch];
        [strM deleteCharactersInRange:range];
    }
    return strM;
}

@end


