//
//  NSString+Extension.h
//  Tag
//
//  Created by tripleCC on 16/1/9.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Draw)
- (void)drawInContext:(CGContextRef)context withPosition:(CGPoint)p andFont:(UIFont *)font andTextColor:(UIColor *)color andHeight:(float)height andWidth:(float)width;
- (void)drawInContext:(CGContextRef)context withFrame:(CGRect)frame andFont:(UIFont *)font andTextColor:(UIColor *)textColor;
@end
