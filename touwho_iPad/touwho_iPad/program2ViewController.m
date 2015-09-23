//
//  program2ViewController.m
//  touwho_iPad
//
//  Created by apple on 15/9/2.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "program2ViewController.h"
#import "programView.h"
#import "sponsorTableViewCell.h"
#import "ModelForSponsor.h"
#import "LingTouViewController.h"

@interface program2ViewController () <UITableViewDataSource,UITableViewDelegate>

//子视图
@property (weak, nonatomic) IBOutlet UIView *program;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;



//用来装所有投资人Cell的模型的数组
@property (strong,nonatomic) NSMutableArray *modelArray;



//按钮点击
- (IBAction)lingtouClick:(UIButton *)sender;
- (IBAction)gentouClick:(UIButton *)sender;

@end

@implementation program2ViewController
{
    programView *viewForprogram;//左上角的项目视图
    UIButton *btn;//关注按钮
    CGFloat height1;//textView1高度
    CGFloat height2;//textView2高度
}
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return  _modelArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    //添加programView视图
    programView *view = [[[NSBundle mainBundle] loadNibNamed:@"programView" owner:nil options:nil]firstObject];
    view.model = self.model1;
    [self.program addSubview:view];
    viewForprogram = view;
    
    //添加关注按钮
    UIButton *followBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [view addSubview:followBtn];
    followBtn.backgroundColor = [UIColor greenColor];
    [followBtn setTitle:@"关注" forState:UIControlStateNormal];
    btn = followBtn;
    
    //注册tableviewCell
    [self.tableView registerNib:[UINib nibWithNibName:@"sponsorCell" bundle:nil] forCellReuseIdentifier:@"sponsorCell"];
    
    //假数据创建模型
    ModelForSponsor *model = [[ModelForSponsor alloc] init];
    model.image = [UIImage imageNamed:@"ywp"];
    model.name = @"杨伟鹏";
    model.amount = @"意向跟投：500万";
    model.time = @"2015.8.15";
    [self.modelArray addObject:model];
    
    ModelForSponsor *model2 = [[ModelForSponsor alloc] init];
    model2.image = [UIImage imageNamed:@"zhw"];
    model2.name = @"郑惠文";
    model2.amount = @"意向跟投：500万";
    model2.time = @"2015.9.15";
    [self.modelArray addObject:model2];
    
    //计算textView高度
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize textView1size = [self.textView1.text boundingRectWithSize:CGSizeMake(self.textView1.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    height1 = textView1size.height + 10;
    
    CGSize textView2size = [self.textView2.text boundingRectWithSize:CGSizeMake(self.textView2.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
    height2 = textView2size.height + 10;
    
    //设置分享按钮
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(share)];
    [self.navigationItem setRightBarButtonItem:shareItem animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
- (void)share{
    NSLog(@"share");
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}

/**
 *  控制器的子视图更新约束(添加一些新视图的约束)
 */
- (void)updateViewConstraints{
    
    [super updateViewConstraints];
    //约束关注按钮
    [self layoutForFollowBtn:btn];
    //约束左上角的view
    [self layoutForProgram:viewForprogram];
    //更改textView1的高度
    for (NSLayoutConstraint *constraint in self.textView1.constraints) {
        if ([constraint.identifier isEqualToString:@"textView1Height"]) {
            constraint.constant = height1;
        }
    }
    //更改textView2的高度
    for (NSLayoutConstraint *constraint in self.textView2.constraints) {
        if ([constraint.identifier isEqualToString:@"textView2Height"]) {
            constraint.constant = height2;
        }
    }
}
- (void)layoutForProgram:(programView *)view{
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.program attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.program addConstraints:@[leading,trailing,top,bottom]];
    view.translatesAutoresizingMaskIntoConstraints = NO;
}
- (void)layoutForFollowBtn:(UIView *)view {
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTrailing multiplier:1 constant:-20];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:view.superview attribute:NSLayoutAttributeTop multiplier:1 constant:20];
    
    [view.superview addConstraints:@[trailing,top]];
    view.translatesAutoresizingMaskIntoConstraints = NO;


}

#pragma mark - tableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    sponsorTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sponsorCell" forIndexPath:indexPath];
    
    cell.model = self.modelArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

#pragma mark - 按钮点击
- (IBAction)lingtouClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"领投" message:@"请在个人中心页面申请领头人资格" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
    [alert addAction:OK];
    [self presentViewController:alert animated:YES completion:NULL];
    
}

- (IBAction)gentouClick:(UIButton *)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"跟投" message:@"请在个人中心页面申请跟投人资格" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *OK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:NULL];
    [alert addAction:OK];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"已申请" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        LingTouViewController *lingVC = [[LingTouViewController alloc] initWithNibName:@"LingTouViewController" bundle:nil];
        lingVC.modalPresentationStyle = UIModalPresentationFormSheet;
        [self presentViewController:lingVC animated:YES completion:NULL];
    }];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
