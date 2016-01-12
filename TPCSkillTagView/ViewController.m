//
//  ViewController.m
//  Tag
//
//  Created by tripleCC on 16/1/7.
//  Copyright © 2016年 tripleCC. All rights reserved.
//

#import "ViewController.h"
#import "BQSkillTagView.h"
#import "BQSkillTag.h"

@interface ViewController () <BQSkillTagViewDelegate>
{
    BQSkillTagView *v;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    d[@"name"] = @"哈啊分";
    d[@"agreeCount"] = @"1";
    NSMutableArray *a = @[].mutableCopy;
    for (int i = 0; i < 100; i++) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        NSMutableString *s = [NSMutableString stringWithFormat:@"0"];
        for (int j = 0; j < i % 5; j++) {
            [s appendFormat:@"%d", i];
        }
        d[@"name"] = s;
        d[@"agreeCount"] = [NSString stringWithFormat:@"%d", i];
        BQSkillTag *t = [BQSkillTag tagWithDict:d];
        [a addObject:t];
    }
    
    NSMutableArray *b = @[].mutableCopy;
    for (int i = 10; i < 100; i++) {
        NSMutableDictionary *d = [NSMutableDictionary dictionary];
        NSMutableString *s = [NSMutableString stringWithFormat:@""];
        for (int j = 0; j < i % 5; j++) {
            [s appendString:@"Li哈"];
        }
        d[@"name"] = s;
        d[@"agreeCount"] = [NSString stringWithFormat:@"%d", i];
        BQSkillTag *t = [BQSkillTag tagWithDict:d];
        [b addObject:t];
    }
    
    
    v = [[BQSkillTagView alloc] initWithFrame:self.view.bounds];
    v.skillTags = a;
    v.availableSkillTags = b;
    v.skillTagsHeaderString = @"啦啦啦啦打领带手拉手的";
    v.availableSkillTagsHeaderString = @"阿大短发短发";
    v.availableSkillType = @"大法";
    v.delegate = self;
    v.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    v.showAddSkillTag = YES;
    [self.view addSubview:v];
}

- (void)skillTagView:(BQSkillTagView *)skillTagView didSelectTagView:(BQSkillTag *)skillTag atIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", skillTag);
    if (indexPath.section == 0) {
        if (skillTag.name.length == 0 && skillTag.agreeCount.length == 0) {
            NSLog(@"添加自定义标签");
        } else {
            skillTag.selected = YES;
            [skillTagView updateSkillTagsWithIndexPath:indexPath];
        }
    } else {
        [skillTagView addSkillTag:skillTag toSection:0];
    }
    
}

- (void)skillTagView:(BQSkillTagView *)skillTagView didTouchTypeButtonWithTypeName:(NSString *)typeName {
    NSLog(@"%@", typeName);
    skillTagView.availableSkillType = @"哈哈哈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
