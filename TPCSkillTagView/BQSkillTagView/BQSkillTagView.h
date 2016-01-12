//
//  BQSkillTagView.h
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BQSkillTagView, BQSkillTag;
@protocol BQSkillTagViewDelegate <NSObject>
@optional
- (void)skillTagView:(BQSkillTagView *)skillTagView didSelectTagView:(BQSkillTag *)skillTag atIndexPath:(NSIndexPath *)indexPath;
- (void)skillTagView:(BQSkillTagView *)skillTagView didTouchTypeButtonWithTypeName:(NSString *)typeName;
@end

@class BQSkillTag;
@interface BQSkillTagView : UIView
/**
 *  现有技能标签
 */
@property (strong, nonatomic) NSMutableArray<BQSkillTag *> *skillTags;
/**
 *  供选择的技能标签
 *  如果为空，则标签头部不会显示
 */
@property (strong, nonatomic) NSMutableArray<BQSkillTag *> *availableSkillTags;
/**
 *  代理
 */
@property (weak, nonatomic) id<BQSkillTagViewDelegate> delegate;
/**
 *  现有技能标签头部标题
 */
@property (copy, nonatomic) NSString *skillTagsHeaderString;
/**
 *  供选择技能标签头部标题
 */
@property (copy, nonatomic) NSString *availableSkillTagsHeaderString;
/**
 *  供选择技能标签所属类型
 */
@property (copy, nonatomic) NSString *availableSkillType;
/**
 *  视图内嵌
 */
@property (assign, nonatomic) UIEdgeInsets contentInset;
/**
 *  是否允许滚动
 *  嵌入UITableView使用
 */
@property (assign, nonatomic) BOOL scrollEnabled;
/**
 *  背景颜色
 */
@property (strong, nonatomic) UIColor *themeBackgroundColor;
/**
 *  是否显示添加技能标签按钮
 *  添加在现有技能标签的最后面
 *  可以用标签模型中name长度为0来进行检索
 */
@property (assign, nonatomic, getter=isShowAddSkillTag) BOOL showAddSkillTag;

/**
 *  更新技能标签
 */
- (void)updateSkillTag:(BQSkillTag *)skillTag inSection:(NSInteger)section;
- (void)updateSkillTagsWithIndexPath:(NSIndexPath *)indexPath;

/**
 *  添加技能标签
 *
 *  @param skillTag 源技能标签
 *  @param section  所在section
 */
- (void)addSkillTag:(BQSkillTag *)skillTag toSection:(NSInteger)section;
/**
 *  删除技能标签
 *
 *  @param skillTag 源技能标签
 *  @param section  所在section
 */
- (void)removeSkillTag:(BQSkillTag *)skillTag fromSection:(NSInteger)section;
@end

@interface BQSkillTagReusableView : UICollectionReusableView
{
    UILabel *_tipLabel;
    UILabel *_typeLabel;
}
@property (assign, nonatomic) UIEdgeInsets contentInset;
@property (weak, nonatomic) UIButton *typeButton;
@property (weak, nonatomic) UIImageView *arrowImageView;
@property (copy, nonatomic) NSString *tipName;
@property (copy, nonatomic) NSString *typeName;
@property (assign, nonatomic, getter=isShowType) BOOL showType;
@property (copy, nonatomic) void(^tapTypeCallBack)(NSString *typeName);
@end

@interface BQSkillTagViewCell : UICollectionViewCell
{
    UILabel *_nameLabel;
    UIImageView *_maskImageView;
}
@property (strong, nonatomic) BQSkillTag *skillTag;
@property (assign, nonatomic) BOOL availableSkillType;
@property (strong, nonatomic) UIImage *maskImage;
@end