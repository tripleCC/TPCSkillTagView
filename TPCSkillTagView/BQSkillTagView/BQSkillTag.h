//
//  BQSkillTag.h
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BQSkillTagFont [UIFont systemFontOfSize:14]
#define BQSkillTagNameLabelX 10
#define BQSkillTagNameLabelH 30
#define BQSkillTagMargin 10
#define BQSkillTagItemH 30

@interface BQSkillTag : NSObject
@property (assign, nonatomic) NSString* agreeCount;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL selected;

@property (assign, nonatomic) CGSize  nameSize;
@property (assign, nonatomic) CGSize agreeCountSize;
@property (assign, nonatomic) CGSize itemSize;

+ (instancetype)tagWithDict:(NSDictionary *)dict;
@end


@interface NSString(BQAutoBounding)
- (CGSize)autoBoundingSize;
@end