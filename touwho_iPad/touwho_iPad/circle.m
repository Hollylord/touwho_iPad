//
//  circle.m
//  touwho_iPad
//
//  Created by apple on 15/8/25.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "circle.h"
#import "JiGouMenuView.h"
#import "xiaozu.h"
#import "ModelForGroup.h"
#import "topics.h"
#import "ModelForTopic.h"
#import "ModelForJiGouUnit.h"

@implementation circle
- (NSMutableArray *)views{
    if (!_views) {
        _views = [NSMutableArray array];
    }
    return _views;
}

//可以创建子视图
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //添加小组到数组中
        xiaozu *view = [[[NSBundle mainBundle] loadNibNamed:@"xiaozu" owner:nil options:nil]firstObject];
        [self.views addObject:view];
       
        topics *view2 = [[[NSBundle mainBundle] loadNibNamed:@"topics" owner:nil options:nil]firstObject];
        [self.views addObject:view2];
        
        JiGouMenuView *view3 = [[JiGouMenuView alloc] init];
        [self.views addObject:view3];
        
    }
    return self;
}

//设置,添加子视图一律在这个方法里面
- (void)awakeFromNib{
    [self.segement addTarget:self action:@selector(segmentValueChanged) forControlEvents:UIControlEventValueChanged];
    [self segmentValueChanged];
}
- (void)updateConstraints{
    [super updateConstraints];
    
    UIView *view = [self.subviews lastObject];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:64];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[leading,trailing,top,bottom]];
}

#pragma mark 添加小组，话题，私信层级关系
- (void)segmentValueChanged {
    
     //小组
    if (self.segement.selectedSegmentIndex == 0) {
        [TalkingData trackEvent:@"查看小组列表"];
        
        [self.views[1] removeFromSuperview];
        [self.views[2] removeFromSuperview];

        xiaozu *view = self.views[0];
        
        
        view.myModels = nil;
        view.hotModels = nil;
        
        //菊花
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        [self pullGroupDataToView:view withCompletion:^{
            
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            [self addSubview:view];
            [self setNeedsUpdateConstraints];
        }];
        
        
        
    }
    //    最新话题
    else if (self.segement.selectedSegmentIndex == 1)
    {
        [TalkingData trackEvent:@"查看话题列表"];
        
        [self.views[0] removeFromSuperview];
        [self.views[2] removeFromSuperview];
        
        topics *view = self.views[1];
        
        
        view.myModels = nil;
        view.hotModels = nil;
        
        //菊花
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        
        [self pullTopicsDataToView:view withCompletion:^{
            
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            [self addSubview:view];
            [self setNeedsUpdateConstraints];
        }];

        
    }
    //机构专题
    else{
        
        [TalkingData trackEvent:@"查看机构列表"];
        
        [self.views[0] removeFromSuperview];
        [self.views[1] removeFromSuperview];
        
        JiGouMenuView *view = self.views[2];
        view.models = nil;
        //菊花
        [MBProgressHUD showHUDAddedTo:self animated:YES];
        [self pullJigouDataToView:view withCompletion:^{
            [MBProgressHUD hideHUDForView:self animated:YES];
            
            [self addSubview:view];
            [self setNeedsUpdateConstraints];
        }];
        
    }
    
}

#pragma mark - 拉取数据
///拉取小组数据
- (void) pullGroupDataToView:(xiaozu *)customView withCompletion:(void (^)())block{

    //获取全部小组
    NSDictionary *para = @{@"method":@"getGroups"};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
        if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
            return ;
        }
       
        //json --> models
        customView.hotModels = [ModelForGroup mj_objectArrayWithKeyValuesArray:[result objectForKey:@"jsonArr"]];
        
        if (USER_ID) {
            //获取我参与的小组
            NSDictionary *dic = @{@"method":@"getMyGroups",@"user_id":USER_ID};
            [BTNetWorking getDataWithPara:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//                NSLog(@"%@",responseObject);
                NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
                if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
                    return ;
                }
                
                //json --> models
                customView.myModels = [ModelForGroup mj_objectArrayWithKeyValuesArray:[result objectForKey:@"jsonArr"]];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        
    
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    block();
    
}

///拉取话题数据
- (void) pullTopicsDataToView:(topics *)customView withCompletion:(void (^)())block{
    
    //获取全部小组
    NSDictionary *para = @{@"method":@"getTalks"};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        
        NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
        if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
            return ;
        }
        
        //json --> models
        
        customView.hotModels = [ModelForTopic mj_objectArrayWithKeyValuesArray:[result objectForKey:@"jsonArr"]];
        
        if (USER_ID) {
            //获取我参与的小组
            NSDictionary *dic = @{@"method":@"getMyTalks",@"user_id":USER_ID};
            [BTNetWorking getDataWithPara:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //            NSLog(@"%@",responseObject);
                
                NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
                if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
                    return ;
                }
                
                //json --> models
                customView.myModels = [ModelForTopic mj_objectArrayWithKeyValuesArray:[result objectForKey:@"jsonArr"]];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    block();
    
}

///获取机构数据
- (void) pullJigouDataToView:(JiGouMenuView *)customView withCompletion:(void (^)())block{
    
    //获取全部小组
    NSDictionary *para = @{@"method":@"getOrganizations"};
    [BTNetWorking getDataWithPara:para success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
        
        NSDictionary *result = [[responseObject objectForKey:@"value"] firstObject];
        if (![[result objectForKey:@"resCode"] isEqualToString:@"0"]) {
            return ;
        }
        
        //json --> models
        customView.models = [ModelForJiGouUnit mj_objectArrayWithKeyValuesArray:[result objectForKey:@"jsonArr"]];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    block();
}
@end
