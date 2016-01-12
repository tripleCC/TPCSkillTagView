//
//  UIColor+Extend.m
//  eSuDi
//
//  Created by iFallen on 5/18/14.
//  Copyright (c) 2014 iFallen. All rights reserved.
//

#import "UIColor+Extend.h"

@implementation UIColor (Extend)

+ (UIColor*) colorWithHex:(long)hexColor;
{
    return [UIColor colorWithHex:hexColor alpha:1.];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity
{
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *)placeHolderColor {
    static UITextField * textFiled = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        textFiled = [[UITextField alloc] init];
        textFiled.placeholder = @"1";
    });
    return [textFiled valueForKeyPath:@"_placeholderLabel.textColor"];
}

@end
