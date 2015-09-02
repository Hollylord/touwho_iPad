//
//  programViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "programViewController.h"
#import "INSSearchBar.h"
#import "myFlowLayout.h"
#import "programView.h"


@interface programViewController () <INSSearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>



//中间的视图
@property (weak,nonatomic) INSSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *pictureCollection;
@property (weak, nonatomic) IBOutlet myFlowLayout *flowLayoutForCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yOfScrollView;
/**
 *  进行中
 */
@property (weak, nonatomic) IBOutlet UILabel *title1;
/**
 *  预热中
 */
@property (weak, nonatomic) IBOutlet UILabel *title2;

/**
 *  进行中的项目
 */
@property (strong,nonatomic) NSMutableArray* programs;
/**
 *  预热中的项目
 */
@property (strong,nonatomic) NSMutableArray* programsForPreparing;
- (IBAction)buttonClick:(UIButton *)sender;


@end

@implementation programViewController
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

#pragma mark - 顶部按钮点击
- (IBAction)buttonClick:(UIButton *)sender {
    
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //搜索框
    INSSearchBar *search = [[INSSearchBar alloc] initWithFrame:CGRectMake(644, 33, 44, 30)];
    [self.view addSubview:search];
    self.searchBar = search;
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor redColor];
    
    //图片滚动
    self.pictureCollection.delegate = self;
    self.pictureCollection.dataSource = self;
    //还是要先注册一个cell
    [self.pictureCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"picture"];
    
    [self.scrollView addSubview:self.title1];//要先将title1添加到scrollview中来。
    //添加进行中项目视图
    for (int i = 0; i < 4; i ++) {
        programView *program = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil] firstObject];
        program.delegate = self;
        program.backgroundColor = [UIColor redColor];
        [self.scrollView addSubview:program];
        [self.programs addObject:program];

    }
    
    [self.scrollView addSubview:self.title2];
    //添加预热中项目视图
    for (int i = 0; i < 4; i ++) {
        programView *program = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil] firstObject];
        program.delegate = self;
        program.backgroundColor = [UIColor greenColor];
        [self.scrollView addSubview:program];
        [self.programsForPreparing addObject:program];
        
    }
    


}
    /** 更新所有主页的约束**/
- (void)updateViewConstraints{
    [super updateViewConstraints];//这句话一定要写
    
    for (int i = 0 ; i < self.programs.count; i ++) {
        [self layoutForProgramView:self.programs[i] index:i];//给programView添加约束
    }
    
    [self layoutForTitle2:self.title2];//给title2添加约束
    
    /** 给预热中项目约束**/
    for (int i = 0 ; i < self.programsForPreparing.count; i ++) {
        [self layoutForPreparingPrograms:self.programsForPreparing[i] index:i];
    }
    
    
}


//在这里才能获得视图的真正frame
- (void)viewDidAppear:(BOOL)animated{
    
    NSIndexPath *goalIndex = [NSIndexPath indexPathForItem:250 inSection:0];
    [self.pictureCollection scrollToItemAtIndexPath:goalIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    //调整scrollView的滚动范围
    programView *lastView = [self.programsForPreparing lastObject];
    self.yOfScrollView.constant = CGRectGetMaxY(lastView.frame) - CGRectGetMaxY(self.pictureCollection.frame) + 20;

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



#pragma mark - 布局
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
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:[self.programs lastObject] attribute:NSLayoutAttributeBottom multiplier:1 constant:30];
    [self.scrollView addConstraints:@[leading,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}

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

#pragma mark - 搜索框的代理
- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(644, 33, 250, 30);
}

- (void)searchBar:(INSSearchBar *)searchBar willStartTransitioningToState:(INSSearchBarState)destinationState
{
    // Do whatever you deem necessary.
}

- (void)searchBar:(INSSearchBar *)searchBar didEndTransitioningFromState:(INSSearchBarState)previousState
{
    // Do whatever you deem necessary.
}

- (void)searchBarDidTapReturn:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
}

- (void)searchBarTextDidChange:(INSSearchBar *)searchBar
{
    // Do whatever you deem necessary.
    // Access the text from the search bar like searchBar.searchField.text
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
    [cell.contentView addSubview:image];
    NSString *imageName = [NSString stringWithFormat:@"ydy%ld",indexPath.item%5+1];
    if (indexPath.item%5 == 0) {
        
        image.image = [UIImage imageNamed:imageName];
    }
    else if (indexPath.item%5 == 1)
    {
        image.image = [UIImage imageNamed:imageName];
    }
    else if (indexPath.item%5 == 2)
    {
        image.image = [UIImage imageNamed:imageName];
    }
    else if (indexPath.item%5 == 3)
    {
        image.image = [UIImage imageNamed:imageName];
    }
    else if (indexPath.item%5 == 4)
    {
        image.image = [UIImage imageNamed:imageName];
    }
    
    return cell;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSIndexPath * currentIndexPath = [[self.pictureCollection indexPathsForVisibleItems]lastObject];
    
    if (currentIndexPath.item == 499) {
        //indexPath item适用于collectionview
        NSIndexPath *goalIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.pictureCollection scrollToItemAtIndexPath:goalIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
    

}








@end
