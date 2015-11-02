//
//  news1ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/27.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "news1ViewController.h"
#import "newsMenu.h"
#import "news2ViewController.h"
#import "ModelForNews.h"

#define MarginSide 50
#define MarginTop 30
#define Width 400
#define Height 150

@interface news1ViewController () <newsMenuDelegate,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;


//存放下拉的所有新闻模型
@property (strong, nonatomic) NSMutableArray *allNewsArr;
//存放所有的新闻view
@property (strong,nonatomic) NSMutableArray *allNewsViewArr;


@end

@implementation news1ViewController
{
    AFHTTPRequestOperationManager *mgr;
    //存放当前总model数
    NSInteger currentCountsOfModel;
    //保存上一次的scrollview的竖直范围约束
    NSLayoutConstraint *constraintOfY;
    //存放最老的新闻id
    NSString *lastNewsID;
    
}
#pragma mark - 懒加载
- (NSMutableArray *)allNewsArr{
    if (!_allNewsArr) {
        _allNewsArr = [NSMutableArray array];
    }
    return _allNewsArr;
}

- (NSMutableArray *)allNewsViewArr{
    if (!_allNewsViewArr) {
        _allNewsViewArr = [NSMutableArray array];
    }
    return _allNewsViewArr;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建加载数据的AFN
    mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //添加下拉刷新
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(pullRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refresh];
    
    //先把它隐藏起来
    self.bottomView.hidden = YES;
    
    //小菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getNewDataWithFresh:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}


- (void)layoutForNewsMenu:(newsMenu *)view index:(int)i{
    //行数
    int line = (int)i/2;
    //列数
    int column = i%2;
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:MarginSide + column*(MarginSide + Width)];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTop multiplier:1 constant:0 + line*(MarginTop + Height)];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Width];
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Height];
    [self.scrollView addConstraints:@[leading,top]];
    [view addConstraints:@[width,height]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (i == currentCountsOfModel-1) {
        if (currentCountsOfModel < 7) {
            //少于7条新闻 滚动范围自己设定
            
        }
        else{
            //这是最后一个view 设置scrollview的contentsize
            NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-74];
            
            //清空原来的y范围
            for (NSLayoutConstraint *constraint in self.scrollView.constraints) {
                if ([constraint isEqual:constraintOfY]) {
                    [self.scrollView removeConstraint:constraint];
                }
            }
            
            //添加y范围
            [self.scrollView addConstraint:bottom];
            constraintOfY = bottom;
        }
        
    }
    
    
}

#pragma mark - newsMenu代理
//跳转新闻详细页面
- (void)turn2newsDetail:(ModelForNews *)model{
    
    news2ViewController *viewcontroller = [[news2ViewController alloc]initWithNibName:@"news2ViewController" bundle:nil];
    viewcontroller.model = model;
    [self.navigationController pushViewController:viewcontroller animated:YES];

}

#pragma mark -  下拉刷新
- (void)pullRefresh:(UIRefreshControl *)refresh{
    [self getNewDataWithFresh:refresh];
}
//获取新数据
- (void)getNewDataWithFresh:(UIRefreshControl *)refresh{
    //设置参数
    NSDictionary *para = @{@"method":@"getNewsTitle_Pre",@"news_id":@"0"};
    //网络请求
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
    
        
        //关闭小菊花
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //情况模型数组
        self.allNewsArr = nil;
        //清空所有的newsView
        for (UIView *view in self.allNewsViewArr) {
            [view removeFromSuperview];
        }
        self.allNewsViewArr = nil;
        
        //获得新闻数组
        NSArray *newsList = [responseObject objectForKey:@"value"];
        //获得最老的新闻id
        lastNewsID = [[newsList lastObject] objectForKey:@"mID"];
 
        
        for (NSDictionary *dic in newsList) {
            
            //转化为model
            [ModelForNews setupReplacedKeyFromPropertyName:^NSDictionary *{
                //设置json和模型名称对应:
                //key:模型名，value：json名
                return @{@"time":@"mCreateTime",@"title":@"mTitle",@"source":@"mSrc",@"mId":@"mID"};
            }];

            //用字典创建模型
           ModelForNews *model = [ModelForNews objectWithKeyValues:dic];

            model.bigImageURL =[NSString stringWithFormat:@"%@%@",SERVER_URL,[dic objectForKey:@"mLargeImageUrl"]];
            model.smallImageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,[dic objectForKey:@"mSmallImageUrl"]];

            
            //存入模型
            [self.allNewsArr addObject:model];
        }
        
        currentCountsOfModel = self.allNewsArr.count;

        if (currentCountsOfModel > 6) {
            //显示刷新view
            self.bottomView.hidden = NO;
        }
        
        //view显示
        for (int i = 0; i < self.allNewsArr.count; i ++) {
            newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
            view.delegate = self;
            view.model = self.allNewsArr[i];
            [self.scrollView addSubview:view];
            [self layoutForNewsMenu:view index:i];
            [self.allNewsViewArr addObject:view];
        }
        
//        测试使用
//        newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
//        [self.scrollView addSubview:view];
//        [self layoutForNewsMenu:view index:6];
//        [self.allNewsViewArr addObject:view];
        
        [self.scrollView setNeedsUpdateConstraints];
        
        //获取数据成功后停止刷新
        [refresh endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - scrollView代理 上拉刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat triggerPointA = scrollView.contentSize.height;
    CGFloat triggerPointB = scrollView.contentOffset.y + scrollView.bounds.size.height;
    if (triggerPointB > triggerPointA + 100) {
        //触发上拉刷新
        self.bottomLabel.text = @"松手加载";
    }
    else{
        self.bottomLabel.text = @"上拉刷新";
    }
}
//手一放开瞬间调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat triggerPointA = scrollView.contentSize.height;
    CGFloat triggerPointB = scrollView.contentOffset.y + scrollView.bounds.size.height;
    if (triggerPointB > triggerPointA+100 && currentCountsOfModel>6) {
        
        //加载网络数据
    
        //设置参数
        NSDictionary *para = @{@"method":@"getNewsTitle_Next",@"news_id":lastNewsID};
        [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//            NSLog(@"%@",responseObject);
            
            //获得新闻数组
            NSArray *newsList = [responseObject objectForKey:@"value"];
            
            //判断有没有错误
            if ([[responseObject objectForKey:@"value"] objectForKey:@"resValue"]) {
                //没有更多的数据
                MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                hud.mode = MBProgressHUDModeText;
                hud.labelText = [[responseObject objectForKey:@"value"] objectForKey:@"resValue"];
                [hud hide:YES afterDelay:0.5];
                return ;
            }
            
            for (NSDictionary *dic in newsList) {
                
                //转化为model
                [ModelForNews setupReplacedKeyFromPropertyName:^NSDictionary *{
                    //设置json和模型名称对应:
                    //key:模型名，value：json名
                    return @{@"time":@"mCreateTime",@"title":@"mTitle",@"source":@"mSrc",@"mId":@"mID"};
                }];
                
                //用字典创建模型
                ModelForNews *model = [ModelForNews objectWithKeyValues:dic];
                model.bigImageURL =[NSString stringWithFormat:@"%@%@",SERVER_URL,[dic objectForKey:@"mLargeImageUrl"]];
                model.smallImageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,[dic objectForKey:@"mSmallImageUrl"]];
            
                
                //存入模型
                [self.allNewsArr addObject:model];
            }
           
        } failure:NULL];
    }
}

//当scrollview完全停止调用
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int temp = (int)currentCountsOfModel;
    currentCountsOfModel = self.allNewsArr.count;
    for (int i = temp; i < self.allNewsArr.count; i ++) {
        newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
        view.delegate = self;
        view.model = self.allNewsArr[i];
        [self.scrollView addSubview:view];
        [self layoutForNewsMenu:view index:i];
        [self.allNewsViewArr addObject:view];
    }
    
    [self.scrollView setNeedsUpdateConstraints];

}
@end
