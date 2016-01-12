//
//  BQSkillTagView.m
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import "BQSkillTagView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "BQSkillTag.h"
#import "UIColor+Extend.h"
#import "NSString+Draw.h"

#define BQSkillTagViewHeaderH 30
#define BQSkillTagViewFooterH 40
@interface BQSkillTagView() <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    __weak UICollectionView *_collectionView;
    NSMutableArray<NSMutableArray *> *_allSkillTags;
}
@property (strong, nonatomic) BQSkillTag *lastSkillTag;;
@end

@implementation BQSkillTagView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UICollectionViewLeftAlignedLayout *leftAlignedLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:leftAlignedLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[BQSkillTagViewCell class] forCellWithReuseIdentifier:NSStringFromClass([BQSkillTagViewCell class])];
        [collectionView registerClass:[BQSkillTagReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BQSkillTagReusableView class])];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.alwaysBounceVertical = YES;
        [self addSubview:collectionView];
        _collectionView = collectionView;
        self.backgroundColor = [UIColor clearColor];
        _allSkillTags = [NSMutableArray array];
    }
    return self;
}

#pragma mark function
- (void)removeSkillTag:(BQSkillTag *)skillTag fromSection:(NSInteger)section {
    if (section < 0 || section > _allSkillTags.count - 1) { return; }
    if (_showAddSkillTag && _allSkillTags.firstObject.lastObject == skillTag) {
        return;
    }
    // Avoiding that there are many same skllTag, then it will remove all and crash
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[_allSkillTags[section] indexOfObject:skillTag] inSection:section];
    [_allSkillTags[section] removeObjectAtIndex:[_allSkillTags[section] indexOfObject:skillTag]];
    [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

- (void)addSkillTag:(BQSkillTag *)skillTag toSection:(NSInteger)section {
    if (section < 0 || section > _allSkillTags.count - 1) { return; }
    NSIndexPath *indexPath = nil;
    if (_showAddSkillTag) {
        [_allSkillTags[section] insertObject:skillTag atIndex:_allSkillTags[section].count - 1];
        indexPath = [NSIndexPath indexPathForItem:_allSkillTags[section].count - 2 inSection:section];
    } else {
        [_allSkillTags[section] addObject:skillTag];
        indexPath = [NSIndexPath indexPathForItem:_allSkillTags[section].count - 1 inSection:section];
    }
    [_collectionView insertItemsAtIndexPaths:@[indexPath]];
}

- (void)updateSkillTag:(BQSkillTag *)skillTag inSection:(NSInteger)section {
    if (section < 0 || section > _allSkillTags.count - 1) { return; }
    NSIndexPath *indexPath= [NSIndexPath indexPathForItem:[_allSkillTags[section] indexOfObject:skillTag] inSection:section];
    [self updateSkillTagsWithIndexPath:indexPath];
}

- (void)updateSkillTagsWithIndexPath:(NSIndexPath *)indexPath {
    [_collectionView reloadItemsAtIndexPaths:@[indexPath]];
}

- (void)updateSkillTags {
    [_collectionView reloadData];
}
#pragma mark getter
- (BQSkillTag *)lastSkillTag {
    if (_lastSkillTag == nil) {
        _lastSkillTag = [[BQSkillTag alloc] init];
        _lastSkillTag.itemSize = CGSizeMake(91, 30);
    }
    return _lastSkillTag;
}

#pragma mark setter
- (void)setAvailableSkillType:(NSString *)availableSkillType {
    _availableSkillType = availableSkillType;
    [_collectionView reloadData];
}

- (void)setAvailableSkillTags:(NSMutableArray<BQSkillTag *> *)availableSkillTags {
    if ([_allSkillTags containsObject:_availableSkillTags]) {
        [_allSkillTags removeObjectAtIndex:_allSkillTags.count - 1];
    }
    _availableSkillTags = availableSkillTags;
    [_allSkillTags addObject:availableSkillTags];
    [_collectionView reloadData];
}

- (void)setSkillTags:(NSMutableArray<BQSkillTag *> *)skillTags {
    if ([_allSkillTags containsObject:_skillTags]) {
        [_allSkillTags removeObjectAtIndex:[_allSkillTags indexOfObject:_skillTags]];
    }
    _skillTags = skillTags;
    [_allSkillTags insertObject:skillTags atIndex:0];
    [_collectionView reloadData];
    if (_showAddSkillTag && skillTags.lastObject != _lastSkillTag) {
        [_allSkillTags.firstObject addObject:self.lastSkillTag];
    }
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    _collectionView.contentInset = UIEdgeInsetsMake(contentInset.top, 0, contentInset.bottom, 0);
    [_collectionView reloadData];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    _collectionView.scrollEnabled = scrollEnabled;
}

- (void)setThemeBackgroundColor:(UIColor *)themeBackgroundColor {
    _themeBackgroundColor = themeBackgroundColor;
    _collectionView.backgroundColor = themeBackgroundColor;
}

- (void)setShowAddSkillTag:(BOOL)showAddSkillTag {
    _showAddSkillTag = showAddSkillTag;
    if (_showAddSkillTag && _skillTags.lastObject != _lastSkillTag) {
        [_allSkillTags.firstObject addObject:self.lastSkillTag];
    }
}

#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _allSkillTags.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _allSkillTags[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BQSkillTagViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([BQSkillTagViewCell class]) forIndexPath:indexPath];
    cell.maskImage = nil;
    cell.skillTag = _allSkillTags[indexPath.section][indexPath.item];
    cell.availableSkillType = indexPath.section != 0;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BQSkillTagReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([BQSkillTagReusableView class]) forIndexPath:indexPath];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader] && (_skillTagsHeaderString.length || _availableSkillTagsHeaderString.length)) {
        if (_skillTagsHeaderString.length && indexPath.section == 0) {
            view.tipName = _skillTagsHeaderString;
            view.showType = NO;
        } else if (_availableSkillTagsHeaderString.length && indexPath.section == 1) {
            view.tipName = _availableSkillTagsHeaderString;
            view.typeName = _availableSkillType;
            [view setTapTypeCallBack:^(NSString *typeName) {
                if ([_delegate respondsToSelector:@selector(skillTagView:didTouchTypeButtonWithTypeName:)]) {
                    [_delegate skillTagView:self didTouchTypeButtonWithTypeName:typeName];
                }
            }];
            view.showType = YES;
        }
        view.bounds = CGRectMake(0, 0, collectionView.bounds.size.width, BQSkillTagViewHeaderH);
        view.contentInset = _contentInset;
        view.hidden = NO;
        return view;
    } else {
        view.hidden = YES;
        return view;
    }
}

#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([_delegate respondsToSelector:@selector(skillTagView:didSelectTagView:atIndexPath:)]) {
        [_delegate skillTagView:self didSelectTagView:_allSkillTags[indexPath.section][indexPath.row] atIndexPath:indexPath];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BQSkillTag *skillTag = _allSkillTags[indexPath.section][indexPath.item];
    if (indexPath.section == 0) {
        return skillTag.itemSize;
    } else {
        return CGSizeMake(skillTag.nameSize.width + BQSkillTagNameLabelX * 2, skillTag.itemSize.height);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ((_skillTagsHeaderString.length && section == 0) || (_availableSkillTagsHeaderString.length && section == 1)) {
        return CGSizeMake(collectionView.bounds.size.width, BQSkillTagViewHeaderH);
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (_skillTagsHeaderString.length && section == 0) {
        return CGSizeMake(collectionView.bounds.size.width, BQSkillTagViewFooterH);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, _contentInset.left, 10, _contentInset.right);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return section == 0 ? 15 : 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}
@end

@implementation BQSkillTagReusableView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.textAlignment = NSTextAlignmentLeft;
        tipLabel.font = [UIFont boldSystemFontOfSize:14.0];
        tipLabel.textColor = [UIColor colorWithHex:0x666666];
        [self addSubview:tipLabel];
        _tipLabel = tipLabel;
        
        UILabel *typeLabel = [[UILabel alloc] init];
        typeLabel.textAlignment = NSTextAlignmentRight;
        typeLabel.font = [UIFont systemFontOfSize:14.0];
        typeLabel.textColor = [UIColor colorWithHex:0x333333];
        [self addSubview:typeLabel];
        _typeLabel = typeLabel;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
#pragma mark 懒加载
- (UIImageView *)arrowImageView
{
    if (_arrowImageView == nil) {
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        [self addSubview:arrowImageView];
        _arrowImageView = arrowImageView;
    }
    
    return _arrowImageView;
}

- (UIButton *)typeButton
{
    if (_typeButton == nil) {
        UIButton *typeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        typeButton.backgroundColor = [UIColor clearColor];
        [typeButton addTarget:self action:@selector(typeButtonOnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:typeButton];
        _typeButton = typeButton;
    }
    
    return _typeButton;
}

- (void)typeButtonOnClicked {
    !_tapTypeCallBack ? : _tapTypeCallBack(_typeName);
}

#pragma mark setter
- (void)setShowType:(BOOL)showType {
    _showType = showType;
    _arrowImageView.hidden = !showType;
    _typeButton.hidden = !showType;
    _typeLabel.hidden = !showType;
    [self layoutIfNeeded];
}

- (void)setTypeName:(NSString *)typeName {
    _typeName = typeName;
    _typeLabel.text = typeName;
    self.arrowImageView.image = [UIImage imageNamed:@"cell_next_icon_blue"];
    [self layoutIfNeeded];
}

- (void)setTipName:(NSString *)tipName {
    _tipName = tipName;
    _tipLabel.text = tipName;
    [self layoutIfNeeded];
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_tipLabel sizeToFit];
    [_typeLabel sizeToFit];
    _tipLabel.frame = CGRectMake(_contentInset.left, 0, _tipLabel.bounds.size.width, self.bounds.size.height);
    CGFloat arrowImageViewHW = 20;
    CGFloat imageLeftMargin = 0;
    _arrowImageView.frame = CGRectMake(self.bounds.size.width - arrowImageViewHW - imageLeftMargin - _contentInset.right, (self.bounds.size.height - arrowImageViewHW) * 0.5, arrowImageViewHW, arrowImageViewHW);
    
    CGFloat imageRightMargin = 10;
    _typeLabel.frame = CGRectMake(CGRectGetMidX(_arrowImageView.frame) - _typeLabel.bounds.size.width - imageRightMargin, 0, _typeLabel.bounds.size.width, self.bounds.size.height);
    self.typeButton.frame = CGRectMake(CGRectGetMinX(_typeLabel.frame), CGRectGetMinY(_typeLabel.frame), CGRectGetMaxX(_arrowImageView.frame) - CGRectGetMinX(_typeLabel.frame), _typeLabel.bounds.size.height);
}
@end

@implementation BQSkillTagViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *maskImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:maskImageView];
        _maskImageView = maskImageView;
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.font = BQSkillTagFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:nameLabel];
        _nameLabel = nameLabel;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
#pragma mark setter
- (void)setMaskImage:(UIImage *)maskImage {
    _maskImage = maskImage;
    _maskImageView.image = maskImage;
}

- (void)setSkillTag:(BQSkillTag *)skillTag {
    _skillTag = skillTag;
    
    _nameLabel.hidden = !_skillTag.name.length;
    _nameLabel.text = _skillTag.name;
    _nameLabel.textColor = _skillTag.selected ? [UIColor whiteColor] : [UIColor colorWithHex:0x333333];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setAvailableSkillType:(BOOL)availableSkillType {
    _availableSkillType = availableSkillType;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (UIBezierPath *)contentPathWithWane:(CGFloat)wane margin:(CGFloat)margin {
    CGFloat buttonH = self.contentView.bounds.size.height;
    CGFloat buttonW = self.contentView.bounds.size.width;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(wane, margin)];
    [path addLineToPoint:CGPointMake(buttonW - wane - margin, margin)];
    [path addArcWithCenter:CGPointMake(buttonW - wane  - margin, wane + margin) radius:wane startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(buttonW - margin, buttonH - wane - margin)];
    [path addArcWithCenter:CGPointMake(buttonW - wane  - margin, buttonH - wane  - margin) radius:wane startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(wane, buttonH - margin)];
    [path addArcWithCenter:CGPointMake(wane + margin, buttonH - wane  - margin) radius:wane startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    [path addLineToPoint:CGPointMake(margin, wane + margin)];
    [path addArcWithCenter:CGPointMake(wane + margin, wane + margin) radius:wane startAngle:M_PI endAngle:M_PI * 1.5 clockwise:YES];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    return path;
}

- (UIBezierPath *)agreeCountPathWithWane:(CGFloat)wane margin:(CGFloat)margin {
    CGFloat buttonH = self.contentView.bounds.size.height;
    CGFloat buttonW = _skillTag.agreeCountSize.width + 2 * BQSkillTagMargin;
    CGFloat buttonX = CGRectGetMaxX(_nameLabel.frame) + BQSkillTagMargin;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(buttonX, margin)];
    [path addLineToPoint:CGPointMake(buttonW - wane - margin + buttonX, margin)];
    [path addArcWithCenter:CGPointMake(buttonW - wane  - margin + buttonX, wane + margin) radius:wane startAngle:-M_PI_2 endAngle:0 clockwise:YES];
    [path addLineToPoint:CGPointMake(buttonW - margin + buttonX, buttonH - wane - margin)];
    [path addArcWithCenter:CGPointMake(buttonW - wane  - margin + buttonX, buttonH - wane  - margin) radius:wane startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path addLineToPoint:CGPointMake(buttonX, buttonH - margin)];
    [path addLineToPoint:CGPointMake(buttonX, margin)];
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    return path;
}

- (void)createBackgroundImage {
    if (_skillTag.name.length == 0 && _skillTag.agreeCount.length == 0) {
        self.maskImage = [UIImage imageNamed:@"添加标签"];
        return;
    }
    
    BQSkillTag *skillTag = _skillTag;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *contentImage = [self createImageWithSelected:_skillTag.selected];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (skillTag == _skillTag) {
                self.maskImage = contentImage;
            }
        });
    });
}

- (UIImage *)createImageWithSelected:(BOOL)selected {
    UIGraphicsBeginImageContextWithOptions(self.contentView.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!selected) {
        [self drawContent:context WithContentColor:[UIColor colorWithHex:0xe9e9e9] agreeColor:[UIColor colorWithHex:0xd9d9d9] textColor:[UIColor colorWithHex:0x333333]];
    } else {
        [self drawContent:context WithContentColor:[UIColor colorWithHex:0x5fd5d9] agreeColor:[UIColor colorWithHex:0x2dc3c8] textColor:[UIColor whiteColor]];
    }
    UIImage *backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return backgroundImage;
}

- (void)drawContent:(CGContextRef)context WithContentColor:(UIColor *)contentColor agreeColor:(UIColor *)agreeColor textColor:(UIColor *)textColor {
    CGFloat wane = 5;
    CGFloat margin = 0;
    [contentColor set];
    [[self contentPathWithWane:wane margin:margin] fill];
    [agreeColor set];
    [[self agreeCountPathWithWane:wane margin:margin] fill];
//    CGRect nameFrame = CGRectZero;
    CGRect agreeFrame = CGRectZero;

    // 这里很奇怪，仅仅在绘制中文时，会出现偏差，文字会偏下，所以name还是用UILabel显示
    if (_availableSkillType) {
//        nameFrame = CGRectMake(0, (self.contentView.bounds.size.height - _skillTag.nameSize.height) * 0.5, CGFLOAT_MAX, BQSkillTagNameLabelH);
    } else {
//        nameFrame = CGRectMake(BQSkillTagNameLabelX, (self.contentView.bounds.size.height - _skillTag.nameSize.height) * 0.5, CGFLOAT_MAX, self.contentView.bounds.size.height);
        agreeFrame = CGRectMake(_skillTag.nameSize.width + BQSkillTagNameLabelX + BQSkillTagMargin * 2, (self.contentView.bounds.size.height - _skillTag.agreeCountSize.height) * 0.5, _skillTag.agreeCountSize.width + 2 * BQSkillTagMargin, self.contentView.bounds.size.height);
    }
//    [_skillTag.name drawInContext:context withFrame:nameFrame andFont:BQSkillTagFont andTextColor:textColor];
    [_skillTag.agreeCount drawInContext:context withFrame:agreeFrame andFont:BQSkillTagFont andTextColor:textColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_availableSkillType) {
        _nameLabel.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, BQSkillTagNameLabelH);
    } else {
        _nameLabel.frame = CGRectMake(BQSkillTagNameLabelX, 0, _skillTag.nameSize.width, BQSkillTagNameLabelH);
    }
    _maskImageView.frame = self.contentView.bounds;
    [self createBackgroundImage];
}

@end
