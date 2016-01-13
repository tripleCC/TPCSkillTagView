//
//  BQSkillTagView.h
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BQSkillTag.h"

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
 *  背景颜色
 */
@property (strong, nonatomic) UIColor *themeBackgroundColor;
/**
 *  通知个数
 *  赋0隐藏
 */
@property (assign, nonatomic) NSInteger notificationCount;
/**
 *  通知栏点击回调
 */
@property (copy, nonatomic) void (^notificationClickCallBack)(NSInteger notificationCount);
/**
 *  是否显示添加技能标签按钮
 *  添加在现有技能标签的最后面
 *  可以用标签模型中name长度为0来进行检索
 */
@property (assign, nonatomic, getter=isShowAddSkillTag) BOOL showAddSkillTag;
/**
 *  是否允许滚动
 *  嵌入UITableView使用
 */
@property (assign, nonatomic) BOOL scrollEnabled;

/**
 *  最后一个cell元素最大Y值
 *  嵌入UITableView使用
 */
@property (assign, nonatomic, readonly) CGFloat skillTagViewHeight;
/**
 *  更新技能标签
 */
- (void)updateSkillTag:(BQSkillTag *)skillTag inSection:(NSInteger)section;
- (void)updateSkillTagsWithIndexPath:(NSIndexPath *)indexPath;
/**
 *  慎用，使用不当会造成标签闪烁
 */
- (void)updateSkillTags;
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
    __weak UILabel *_tipLabel;
    __weak UILabel *_typeLabel;
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
    __weak UILabel *_nameLabel;
    __weak UIImageView *_maskImageView;
}
@property (strong, nonatomic) BQSkillTag *skillTag;
@property (assign, nonatomic) BOOL availableSkillType;
@property (strong, nonatomic) UIImage *maskImage;
@end

@interface BQSkillTagNotificationView : UIView
{
    __weak UIImageView *_arrowImageView;
    __weak UILabel *_notificationLabel;
}
@property (assign, nonatomic) NSInteger notificationCount;
@property (copy, nonatomic) void(^clickCallBack)(NSInteger notificationCount);
@end