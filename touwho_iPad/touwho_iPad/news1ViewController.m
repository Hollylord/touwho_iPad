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

@interface news1ViewController () <newsMenuDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//存放下拉的所有新闻模型
@property (strong, nonatomic) NSMutableArray *allNewsArr;


@end

@implementation news1ViewController
{
    AFHTTPRequestOperationManager *mgr;
}
- (NSMutableArray *)allNewsArr{
    if (!_allNewsArr) {
        _allNewsArr = [NSMutableArray array];
    }
    return _allNewsArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建加载数据的AFN
    mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //添加下拉刷新
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(pullRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:refresh];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //小菊花
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getNewDataWithFresh:nil];
    
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
    [self.scrollView layoutIfNeeded];
    //设置滚动范围
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(view.frame) + 2000);
}

#pragma mark - newsMenu代理
//跳转新闻详细页面
- (void)turn2newsDetail{
    
    news2ViewController *viewcontroller = [[news2ViewController alloc]initWithNibName:@"news2ViewController" bundle:nil];
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
        
        //关闭小菊花
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        //情况模型数组
        self.allNewsArr = nil;
        
        //获得新闻数组
        NSArray *newsList = [responseObject objectForKey:@"value"];
        for (NSDictionary *dic in newsList) {
            //解析json
            NSString *time = [dic objectForKey:@"mCreateTime"];
            NSString *smallImageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,[dic objectForKey:@"mSmallImageUrl"]];
            NSString *title = [dic objectForKey:@"mTitle"];
            
            //转化为model
            ModelForNews *model = [[ModelForNews alloc] init];
            model.time = time;
            model.smallImageURL = smallImageURL;
            model.title = title;
            
            //存入模型
            [self.allNewsArr addObject:model];
        }
        
        for (int i = 0; i < self.allNewsArr.count; i ++) {
            newsMenu *view = [[[NSBundle mainBundle]loadNibNamed:@"newsMenu" owner:nil options:nil]firstObject];
            view.delegate = self;
            view.model = self.allNewsArr[i];
            [self.scrollView addSubview:view];
            [self layoutForNewsMenu:view index:i];
        }
        
        //获取数据成功后停止刷新
        [refresh endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
