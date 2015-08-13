//
//  programViewController.m
//  touwho_iPad
//
//  Created by apple on 15/8/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "programViewController.h"
#import "INSSearchBar.h"

@interface programViewController () <INSSearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UIButton *programBtn;
@property (weak, nonatomic) IBOutlet UIButton *newsBtn;
@property (weak, nonatomic) IBOutlet UIButton *findBtn;
@property (weak, nonatomic) IBOutlet UIButton *meBtn;
@property (weak,nonatomic) INSSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UICollectionView *pictureCollection;

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
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath;
{
    UICollectionViewCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"picture" forIndexPath:indexPath];
    
    return cell;
}
@end
