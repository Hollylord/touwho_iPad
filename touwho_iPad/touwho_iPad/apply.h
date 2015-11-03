//
//  apply.h
//  touwho_iPad
//
//  Created by apple on 15/9/30.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface apply : UIView
@property (weak, nonatomic) IBOutlet UILabel *enterpriseIdentify;
@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;
@property (weak, nonatomic) IBOutlet UITextView *serviceContentView;
///用来标识是申请领头还是跟投资格的
@property (assign,nonatomic) BOOL isLingtou;
@property (weak, nonatomic) IBOutlet UITextField *reasonView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
