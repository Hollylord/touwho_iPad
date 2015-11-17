//
//  programViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "programViewController.h"
#import "program2ViewController.h"
#import "myFlowLayout.h"
#import "programView.h"
#import "ModelForProgramView.h"
#import "ModelPhotos.h"


@interface programViewController () <UICollectionViewDataSource,UICollectionViewDelegate,programViewDelegate,UIGestureRecognizerDelegate>

//顶部四个按钮
@property (weak, nonatomic) IBOutlet UIButton *topBtn1;
@property (weak, nonatomic) IBOutlet UIButton *topBtn2;
@property (weak, nonatomic) IBOutlet UIButton *topBtn3;
@property (weak, nonatomic) IBOutlet UIButton *topBtn4;



//中间的视图
@property (weak, nonatomic) IBOutlet UICollectionView   * pictureCollection;
@property (weak, nonatomic) IBOutlet myFlowLayout       * flowLayoutForCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView       *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * yOfScrollView;

//进行中
@property (weak, nonatomic) IBOutlet UILabel *title1;
//预热中
@property (weak, nonatomic) IBOutlet UILabel *title2;
//已结束
@property (weak, nonatomic) IBOutlet UILabel *title3;

//保存进行中的programView
@property (strong,nonatomic) NSMutableArray* programs;
//保存预热中的programView
@property (strong,nonatomic) NSMutableArray* programsForPreparing;
//保存已结束的programView
@property (strong,nonatomic) NSMutableArray* programsForFinished;

//存放进行中的model
@property (strong,nonatomic) NSMutableArray *modelsOngoing;
//存放预热中的model
@property (strong,nonatomic) NSMutableArray *modelsPreparing;
//存放结束的model
@property (strong,nonatomic) NSMutableArray *modelsFinished;

///存放轮播图的models
@property (strong,nonatomic) NSMutableArray *modelsPhoto;

- (IBAction)buttonClick:(UIButton *)sender;


@end

@implementation programViewController
{
    UIRefreshControl *fresh;
    NSIndexPath *currentPath;
    AFHTTPRequestOperationManager *mgr;
    
}

#pragma mark - 懒加载
- (NSMutableArray *)programs{
    if (_programs == nil) {
       _programs = [NSMutableArray array];
    }
    return _programs;
}
- (NSMutableArray *)programsForPreparing{
    if (!_programsForPreparing) {
        _programsForPreparing = [NSMutableArray array];
    }
    return _programsForPreparing;
}
- (NSMutableArray *)programsForFinished{
    if (!_programsForFinished) {
        _programsForFinished = [NSMutableArray array];
    }
    return _programsForFinished;
}

- (NSMutableArray *)modelsOngoing{
    if (!_modelsOngoing) {
        _modelsOngoing = [NSMutableArray array];
    }
    return _modelsOngoing;
}
- (NSMutableArray *)modelsPreparing{
    if (!_modelsPreparing) {
        _modelsPreparing = [NSMutableArray array];
    }
    return _modelsPreparing;
}
- (NSMutableArray *)modelsFinished{
    if (!_modelsFinished) {
        _modelsFinished = [NSMutableArray array];
    }
    return _modelsFinished;
}

#pragma mark - 顶部按钮点击
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.selected == YES) {
        return ;
    }
    
    //点击了国内项目
    if (sender.tag == 10) {
        sender.selected = !sender.selected;
        self.topBtn2.selected = NO;
        [self pullRefresh:fresh];
    }
    //点击海外项目
    else if (sender.tag == 11){
        sender.selected = !sender.selected;
        self.topBtn1.selected = NO;
        [self pullRefresh:fresh];
    }
    //商品众筹
    else if (sender.tag == 12){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"商品众筹" message:@"敬请期待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:NULL];
    }
    //公益活动
    else if (sender.tag == 13){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"公益活动" message:@"敬请期待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
        [alert addAction:OK];
        [self presentViewController:alert animated:YES completion:NULL];
    }
    
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建加载数据的AFN
    mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    //图片滚动
    self.pictureCollection.delegate   = self;
    self.pictureCollection.dataSource = self;
    
    //还是要先注册一个cell
    [self.pictureCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"picture"];
    
    //设置顶部按钮的状态
    self.topBtn1.selected  = YES;
    
    //给scrollview添加refreshControl (自动添加到scrollview的顶部不用设置frame)
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    [refresh addTarget:self action:@selector(pullRefresh:) forControlEvents:UIControlEventValueChanged];
    fresh = refresh;
    [self.scrollView addSubview:refresh];
    
    //小菊花
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.dimBackground = YES;
    
    //第一次触发刷新
    [self pullRefresh:refresh];
    
    //获取轮播图内容
    [self pullImage];
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //去除导航栏
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSIndexPath *goalIndex = [NSIndexPath indexPathForItem:250 inSection:0];
    currentPath = goalIndex;
    [self.pictureCollection scrollToItemAtIndexPath:goalIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





#pragma mark - collection代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return 500;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    //cv.indexPathsForVisibleItems 是可视范围内的index，而indexPath是所有的index
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"picture" forIndexPath:indexPath];

    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height)];
    
    
    //不设置yes 不能点击
    image.userInteractionEnabled = YES;
    [cell.contentView addSubview:image];
    
    if (self.modelsPhoto.count >= 5) {
        ModelPhotos *model = self.modelsPhoto[indexPath.item%5];
        
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",SERVER_URL,model.mImageUrl];
        NSURL *url = [NSURL URLWithString:imageURL];
        
        [image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"zhanweitu"]];
    }
    
    
//    if (indexPath.item%5 == 0) {
//        
//        image.image = [UIImage imageNamed:imageName];
//    }
//    else if (indexPath.item%5 == 1)
//    {
//        image.image = [UIImage imageNamed:imageName];
//    }
//    else if (indexPath.item%5 == 2)
//    {
//        image.image = [UIImage imageNamed:imageName];
//    }
//    else if (indexPath.item%5 == 3)
//    {
//        image.image = [UIImage imageNamed:imageName];
//    }
//    else if (indexPath.item%5 == 4)
//    {
//        image.image = [UIImage imageNamed:imageName];
//    }
    
    return cell;
}



//滚动时就触发这个方法, 持续触发。代码scroll会触发这个方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //获得当前可视范围内第一个item的indexPath
    NSIndexPath * currentIndexPath = [[self.pictureCollection indexPathsForVisibleItems]firstObject];
    
    
    if (currentIndexPath.item == 499) {
        //indexPath item适用于collectionview
        NSIndexPath *goalIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.pictureCollection scrollToItemAtIndexPath:goalIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }

}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


//由于flowout的cell的变形导致 此方法不响应！
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - 点击项目跳转页面
- (void)turn2DetailOfProgramsWithModel:(ModelForProgramView *)model{
    NSMutableDictionary *user = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSString  *userID = [user objectForKey:@"userID"];
    if (userID) {
        //已登录
        program2ViewController *viewController = [[program2ViewController alloc]initWithNibName:@"program2ViewController" bundle:nil];
        viewController.model1 = model;
        
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"您尚未登录，请登陆后查看详情！";
        [hud hide:YES afterDelay:1];
        hud.dimBackground = YES;
    }
    
}

#pragma mark - 刷新页面获取网络数据
//拉取数据
- (void)pullRefresh:(UIRefreshControl *)refresh{
    //清空数据
    self.modelsFinished = nil;
    self.modelsOngoing = nil;
    self.modelsPreparing = nil;
    self.programs = nil;
    self.programsForFinished = nil;
    self.programsForPreparing = nil;
    
    //设置参数
    NSString *userID = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"userID"];
    NSString *type;
    if (self.topBtn1.selected) {
        type = @"1";
    }
    else if (self.topBtn2.selected){
        type = @"4";
    }
    else if (self.topBtn3.selected){
        type = @"2";
    }
    else if (self.topBtn4.selected){
        type = @"3";
    }
    
    //获取正在进行的数据
    [self getDataForOngoingProgramsWithType:type andUserID:userID withCompletionBlock:^{
        //获取预热中的数据
        [self getDataForPreparingProgramsWithType:type andUserID:userID withCompletionBlock:^{
            //获取已结束的数据
            [self getDataForFinishedProgramsWithType:type andUserID:userID withCompletionBlock:^{
                //显示数据并重新布局
                [self layoutProgramViewsAfterGetData];
                //去除小菊花
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }];
        }];
    }];
    
    
    //获取数据成功后停止刷新
    [refresh endRefreshing];
}

//获取正在进行中的项目
- (void) getDataForOngoingProgramsWithType:(NSString *)type andUserID:(NSString *)userID withCompletionBlock:(void (^)())block{
    //设置进行中的项目
    NSDictionary *para;
    if (userID) {
        //用户已登录
        para = @{@"method":@"getRunningProject",@"user_id":userID,@"type":type};
    }
    else{
        para = @{@"method":@"getRunningProject",@"type":type};
    }
    
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            if (![resCode isEqualToString:@"0"]) {
                return ;
            }
            
            //json数组-->模型数组
            self.modelsOngoing = [ModelForProgramView objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        
        
        block();
        

        
    } failure:NULL];
}

//获取预热中的项目
- (void) getDataForPreparingProgramsWithType:(NSString *)type andUserID:(NSString *)userID withCompletionBlock:(void (^)())block{
    
    NSDictionary *para;
    if (userID) {
        //用户已登录
        para = @{@"method":@"getPrepareProject",@"user_id":userID,@"type":type};
    }
    else{
        para = @{@"method":@"getPrepareProject",@"type":type};
    }
    
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //        NSLog(@"%@",responseObject);
        
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            if (![resCode isEqualToString:@"0"]) {
                return ;
            }
            
            //json数组-->模型数组
            self.modelsPreparing = [ModelForProgramView objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        
        block();
        
    } failure:NULL];

}

- (void)getDataForFinishedProgramsWithType:(NSString *)type andUserID:(NSString *)userID withCompletionBlock:(void (^)())block{
    
    NSDictionary *para;
    if (userID) {
        //用户已登录
        para = @{@"method":@"getFinishProject",@"user_id":userID,@"type":type};
    }
    else{
        para = @{@"method":@"getFinishProject",@"type":type};
    }
    
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //        NSLog(@"%@",responseObject);
        
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            if (![resCode isEqualToString:@"0"]) {
                return ;
            }
            
            //json数组-->模型数组
            self.modelsFinished = [ModelForProgramView objectArrayWithKeyValuesArray:jsonArr];
        }];
        
        
        block();
        
    } failure:NULL];
}

#pragma mark - 布局
- (void)layoutProgramViewsAfterGetData{
    
    if (self.modelsOngoing.count > 0) {
        
        self.title1.hidden = NO;
        [self layoutForTitle1:self.title1];
        
        //添加进行中项目视图
        for (int i = 0; i < self.modelsOngoing.count; i ++) {
            programView *program = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil] firstObject];
            //传递数据
            program.model = self.modelsOngoing[i];
            program.delegate        = self;
            //添加view
            [self.scrollView addSubview:program];
            [self.programs addObject:program];
            [self layoutForProgramView:self.programs[i] index:i];
        }
        
        
        //调整scrollView的滚动范围
        programView *lastView = [self.programs lastObject];
        [self configureScrollViewContentSizeWithLastiView:lastView andPriority:300];
        
    }
    if (self.modelsPreparing.count > 0){
        //布局 title2
        [self.title2 setHidden:NO];
        [self layoutForTitle2:self.title2];
        
        //添加进行中项目视图
        for (int i = 0; i < self.modelsPreparing.count; i ++) {
            programView *program = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil] firstObject];
            //传递数据
            program.model = self.modelsPreparing[i];
            program.delegate        = self;
            //添加view
            [self.scrollView addSubview:program];
            [self.programsForPreparing addObject:program];
            [self layoutForPreparingPrograms:self.programsForPreparing[i] index:i];
        }
        
        //调整scrollView的滚动范围
        programView *lastView = [self.programsForPreparing lastObject];
        [self configureScrollViewContentSizeWithLastiView:lastView andPriority:500];
    }
    if (self.modelsFinished.count > 0){
        //布局 title3
        [self.title3 setHidden:NO];
        [self layoutForTitle3:self.title3];
        
        //添加已结束中项目视图
        for (int i = 0; i < self.modelsFinished.count; i ++) {
            programView *program = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil] firstObject];
            //传递数据
            program.model = self.modelsFinished[i];
            program.delegate        = self;
            //添加view
            [self.scrollView addSubview:program];
            [self.programsForFinished addObject:program];
            [self layoutForFinishedPrograms:self.programsForFinished[i] index:i];
        }
        
        //调整scrollView的滚动范围
        programView *lastView = [self.programsForFinished lastObject];
        [self configureScrollViewContentSizeWithLastiView:lastView andPriority:1000];

    }
    
    //更新约束
    [self.scrollView setNeedsUpdateConstraints];

}

- (void)configureScrollViewContentSizeWithLastiView:(programView *)lastView andPriority:(NSInteger)priority{
    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:lastView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20];
    bottom.priority = priority;
    [self.scrollView addConstraint:bottom];
}

- (void)layoutForTitle1:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint *top1 = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pictureCollection attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    
    
    [self.scrollView addConstraints:@[leading,top1]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

//进行中的项目 布局
- (void)layoutForProgramView:(programView *)programView index:(int )indexPath{
    
    //项目视图在左半边
    if (indexPath%2 == 0) {
        NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title1 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + indexPath/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[leading,top]];
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
        
        
        
    }
    //在右半边
    else {
        NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title1 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + (indexPath-1)/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[trailing,top]];
        
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

- (void)layoutForTitle2:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint *top;
    if (self.programs.count > 0) {
        top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self.programs lastObject] attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    }
    else{
        top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pictureCollection attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    }
  
    
    [self.scrollView addConstraints:@[leading,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

//预热中的项目 布局
- (void)layoutForPreparingPrograms:(programView *)programView index:(int )indexPath{
    
    //项目视图在左半边
    if (indexPath%2 == 0) {
        NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title2 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + indexPath/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[leading,top]];
        
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    //在右半边
    else {
        NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title2 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + (indexPath-1)/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[trailing,top]];
        
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
}

- (void)layoutForTitle3:(UIView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
    NSLayoutConstraint *top;
    if (self.programsForPreparing.count > 0) {
        top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self.programsForPreparing lastObject] attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    }
    else if (self.programs > 0){
        top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self.programs lastObject] attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    }
    else{
        top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.pictureCollection attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    }
    [self.scrollView addConstraints:@[leading,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

//已结束的项目 布局
- (void)layoutForFinishedPrograms:(programView *)programView index:(int )indexPath{
    
    //项目视图在左半边
    if (indexPath%2 == 0) {
        NSLayoutConstraint* leading = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeLeading multiplier:1 constant:30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title3 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + indexPath/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[leading,top]];
        
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
        
    }
    //在右半边
    else {
        NSLayoutConstraint* trailing = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeTrailing multiplier:1 constant:-30];
        NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.title3 attribute:NSLayoutAttributeBottom multiplier:1 constant:20 + (indexPath-1)/2*(250 + 20)];
        NSLayoutConstraint* width = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:415];
        NSLayoutConstraint* height = [NSLayoutConstraint constraintWithItem:programView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:250];
        [self.scrollView addConstraints:@[trailing,top]];
        
        [programView addConstraints:@[width,height]];
        programView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
}

#pragma mark - 轮播图
//点击collectionviewcell
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    //手滑了多少张
    int i = ABS(self.pictureCollection.contentOffset.x - 94768)/380;
    //确定第几页
    NSInteger page = i%5 + 1;
    //拿到确定的页数，跳转相应的页面
    NSLog(@"%ld",(long)page);
    
}


//是否识别这个touch
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    //判断点击位置是否在我设定的区域
    CGPoint touchPoint = [touch locationInView:self.pictureCollection];
     return  CGRectContainsPoint(CGRectMake(132+self.pictureCollection.contentOffset.x, 10, 600, 192), touchPoint);
}

///获取轮播图的data
- (void)pullImage{
    NSDictionary *para = @{@"method":@"getBanner"};
    [mgr GET:SERVER_API_URL parameters:para success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//        NSLog(@"%@",responseObject);
        
        [BTNetWorking analyzeResponseObject:responseObject andCompletionBlock:^(NSArray *jsonArr, NSString *resCode) {
            
            if (![resCode isEqualToString:@"0"]) {
                return ;
            }
            
            //json -- >model
            self.modelsPhoto = [ModelPhotos objectArrayWithKeyValuesArray:jsonArr];
            
            //刷新数据
            [self.pictureCollection reloadData];
            
        }];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
@end
