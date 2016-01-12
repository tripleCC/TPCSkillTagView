//
//  BQSkillTag.m
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import "BQSkillTag.h"

@implementation BQSkillTag
+ (instancetype)tagWithDict:(NSDictionary *)dict {
    BQSkillTag *tag = [[self alloc] init];
    tag.agreeCount = dict[@"agreeCount"];
    tag.name = dict[@"name"];
    tag.nameSize = tag.name.autoBoundingSize;
    tag.agreeCountSize = tag.agreeCount.autoBoundingSize;
    tag.itemSize = CGSizeMake(BQSkillTagNameLabelX + tag.nameSize.width + BQSkillTagMargin + tag.agreeCountSize.width + 2 * BQSkillTagMargin, BQSkillTagItemH);
    return tag;
}

- (void)setName:(NSString *)name {
    _name = name;
    _nameSize = _name.autoBoundingSize;
    _itemSize = CGSizeMake(BQSkillTagNameLabelX + _nameSize.width + BQSkillTagMargin + _agreeCountSize.width + 2 * BQSkillTagMargin, BQSkillTagItemH);
}

- (void)setAgreeCount:(NSString *)agreeCount {
    _agreeCount = agreeCount;
    _agreeCountSize = _agreeCount.autoBoundingSize;
    _itemSize = CGSizeMake(BQSkillTagNameLabelX + _nameSize.width + BQSkillTagMargin + _agreeCountSize.width + 2 * BQSkillTagMargin, BQSkillTagItemH);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"agreeCount=%@, name=%@", _agreeCount, _name];
}
@end

@implementation NSString(BQAutoBounding)
- (CGSize)autoBoundingSize {
    return [self boundingRectWithSize:[UIScreen mainScreen].bounds.size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : BQSkillTagFont} context:nil].size;
}
@end
