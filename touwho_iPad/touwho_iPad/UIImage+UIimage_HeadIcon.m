//
//  UIImage+UIimage_HeadIcon.m
//  touwho_iPad
//
//  Created by apple on 15/9/18.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "UIImage+UIimage_HeadIcon.h"

@implementation UIImage (UIimage_HeadIcon)
+ (UIImage *)imageClipsWithHeadIcon:(UIImage *)image sideWidth:(CGFloat)lineWidth{
    //开启并拿到image上下文
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    //圆的边框宽度为2，颜色为红色
    //设置线宽为2
    CGContextSetLineWidth(context,2);
    //裁剪路径
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
    //裁剪
    CGContextClip(context);
    
    //    ios9 不需要转换控件坐标系了？
    CGContextDrawImage(context, CGRectMake(0, 0, image.size.width, image.size.height), image.CGImage);
    
    
    
    //画边框
    CGContextAddEllipseInRect(context, CGRectMake(0, 0, image.size.width, image.size.height));
    //宽高比
    CGFloat r = image.size.width/image.size.height;
    CGFloat x = lineWidth;
    CGFloat y = x * r;
    CGFloat wid = image.size.width - x * 2;
    CGFloat hei = wid * r;
    CGContextAddEllipseInRect(context, CGRectMake(x,y,wid,hei));
    //填充
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextEOFillPath(context);
    
    
    
    
    //生成新的image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newimg;

}
@end
