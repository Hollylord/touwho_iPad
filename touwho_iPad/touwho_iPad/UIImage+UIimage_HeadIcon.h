//
//  UIImage+UIimage_HeadIcon.h
//  touwho_iPad
//
//  Created by apple on 15/9/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIimage_HeadIcon)
/**
 *  裁剪正方形image成圆形头像
 *
 *  @param image <#image description#>
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageClipsWithHeadIcon:(UIImage *)image sideWidth:(CGFloat)lineWidth;
@end
