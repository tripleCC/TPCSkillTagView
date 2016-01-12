//
//  UIColor+Extend.h
//  eSuDi
//
//  Created by iFallen on 5/18/14.
//  Copyright (c) 2014 iFallen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

+ (UIColor *) colorWithHex:(long)hexColor;
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;

+ (UIColor *)placeHolderColor;

@end
