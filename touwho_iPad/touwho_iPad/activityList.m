//
//  activityList.m
//  touwho_iPad
//
//  Created by apple on 15/9/15.
//  Copyright © 2015年 touhu.com. All rights reserved.
//
#define MarginSide 30
#define MarginTop 30
#define Width 400
#define Height 150

#import "activityList.h"
#import "activityUnit.h"
#import "ModelForActivity.h"

@interface activityList ()
///存放模型数组
@property (strong, nonatomic) NSMutableArray *models;
///存放所有动态添加的view
@property (strong, nonatomic) NSMutableArray *customViews;
@end

@implementation activityList
{
    UIScrollView *scrollView;
}
- (NSMutableArray *)models{
    if (!_models) {
        _models = [NSMutableArray array];
    }
    return _models;
}
- (NSMutableArray *)customViews{
    if (!_customViews) {
        _customViews = [NSMutableArray array];
    }
    return _customViews;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        UIScrollView *scroll = [[UIScrollView alloc] init];
        scrollView = scroll;
        [self addSubview:scrollView];
        //scrollview中内含有滚动条，也会占到它的subview中
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        
        //菊花
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        [self pullData];

    }
    return  self;
}

//动态添加的约束 不要放在这里；
- (void)updateConstraints{
    [super updateConstraints];
    
    //给scrollView添加约束
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:scrollView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:scrollView.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [scrollView.superview addConstraints:@[leading,trailing,top,bottom]];
    scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
    
}

#pragma mark - 获取数据
- (void)pullData{
    
    //1. 获取数据
    NSDictionary *para = @{@"method":@"getActivity"};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        //关闭菊花
        [MBProgressHUD hideHUDForView:self animated:YES];
        
        //json --> model
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            self.models = [ModelForActivity objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        
        //2 显示数据
        for (int i = 0; i < self.models.count; i ++) {
            activityUnit *view = [[[NSBundle mainBundle] loadNibNamed:@"activityUnit" owner:nil options:nil] firstObject];
            
            [self.customViews addObject:view];
            //传递数据
            view.model = self.models[i];
            //只能在self的基础上添加，不能在self的子视图上添加子控件
            [scrollView addSubview:view];
        }
        
        //3 更新约束
        // 给activityUnit添加约束
        for (int i = 0 ; i < self.customViews.count; i ++) {
            UIView *view = self.customViews[i];
            int column = i % 2;//列数
            int line = (int) i / 2;//行数
            
            NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeLeading multiplier:1 constant: MarginSide + column * (MarginSide + Width)];
            NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:MarginTop + line *(MarginTop + Height)];
            NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
            NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
            
            [view.superview addConstraints:@[leading,top]];
            [view addConstraints:@[width,height]];
            view.translatesAutoresizingMaskIntoConstraints = NO;
        }
        
        //        设置scrollview的滚动范围
        if (self.customViews.count > 0) {
            UIView *view = self.customViews.lastObject;
            NSLayoutConstraint *trailing2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
            
            NSLayoutConstraint *bottom2 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
            [view.superview addConstraints:@[trailing2,bottom2]];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"%@",error);
    }];
}

@end
