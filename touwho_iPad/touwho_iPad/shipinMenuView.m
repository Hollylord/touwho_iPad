//
//  shipinMenuView.m
//  touwho_iPad
//
//  Created by apple on 15/8/20.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "shipinMenuView.h"
#import "shipinView.h"
#import "shipinViewController.h"
#import "ModelForFootage.h"

#define MarginSide 30
#define MarginTop 30
#define Width 200
#define Height 200

@interface shipinMenuView ()
///存放模型数组
@property (strong, nonatomic) NSMutableArray *models;
///存放所有动态添加的view
@property (strong, nonatomic) NSMutableArray *customViews;
@end

@implementation shipinMenuView
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
        
        //1. 获取数据
        NSDictionary *para = @{@"method":@"getActivity"};
        [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            //json --> model
            self.models = [ModelForFootage objectArrayWithKeyValuesArray:[responseObject objectForKey:@"value"]];
            
            //2 显示数据
            for (int i = 0; i < self.models.count; i ++) {
                shipinView *view = [[[NSBundle mainBundle] loadNibNamed:@"shipinView" owner:self options:nil] firstObject];
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
    return  self;
}

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
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    UIViewController *VC = [self viewController];
    shipinViewController *shipinVC = [[shipinViewController alloc] initWithNibName:@"shipinViewController" bundle:nil];
    [VC.navigationController pushViewController:shipinVC animated:YES];
}
//获得当前view的控制器
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
