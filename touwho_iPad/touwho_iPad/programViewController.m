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

@interface programViewController () <INSSearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UIButton *programBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *meBtn;
@property (weak,nonatomic) INSSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *pictureCollection;
@property (weak, nonatomic) IBOutlet myFlowLayout *flowLayoutForCollectionView;

- (IBAction)program:(UIButton *)sender;
- (IBAction)news:(UIButton *)sender;
- (IBAction)find:(UIButton *)sender;
- (IBAction)me:(UIButton *)sender;

@end

@implementation programViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //搜索框
    INSSearchBar *search = [[INSSearchBar alloc] initWithFrame:CGRectMake(744, 42, 44, 30)];
    [self.view addSubview:search];
    self.searchBar = search;
    self.searchBar.delegate = self;
    self.searchBar.backgroundColor = [UIColor redColor];
    
    //图片滚动
    self.pictureCollection.delegate = self;
    self.pictureCollection.dataSource = self;
    self.pictureCollection.frame = CGRectMake(30, 84, 864, 218);
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    self.pictureCollection.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
//    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self.pictureCollection reloadItemsAtIndexPaths:@[index]];
//    [self.pictureCollection layoutIfNeeded];
  
    NSLog(@"%@",NSStringFromCGRect(self.pictureCollection.frame) );
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - 按钮点击
- (IBAction)program:(UIButton *)sender {
}

- (IBAction)news:(UIButton *)sender {
}

- (IBAction)find:(UIButton *)sender {
}

- (IBAction)me:(UIButton *)sender {
}

#pragma mark - 搜索框的代理
- (CGRect)destinationFrameForSearchBar:(INSSearchBar *)searchBar
{
    return CGRectMake(744, 42, 250, 30);
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
//    NSLog(@"%@",currentIndexPath);
    if (currentIndexPath.item == 499) {
        //indexPath item适用于collectionview
        NSIndexPath *goalIndex = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.pictureCollection scrollToItemAtIndexPath:goalIndex atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    }
}


@end
