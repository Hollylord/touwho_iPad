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
    
    //找出图片边长最小值
    CGFloat length = MIN(image.size.width, image.size.height);
    
    //裁剪路径
    CGContextAddEllipseInRect(context, CGRectMake((image.size.width - length)/2, (image.size.height - length)/2, length, length));
    //裁剪
    CGContextClip(context);
    
    //  若要转换坐标系，记得是坐标系在变，里面的图片的位置是不变的
    //自适应坐标系，再也不用担心坐标系的问题了。这里的rect 为image的bounds，默认写法不要变。
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    //画外圆
    CGContextAddEllipseInRect(context, CGRectMake((image.size.width - length)/2, (image.size.height - length)/2, length, length));
    //画内圆
    CGContextAddEllipseInRect(context, CGRectMake((image.size.width - length)/2 + lineWidth, (image.size.height - length)/2 + lineWidth, length - 2 *lineWidth, length - 2 *lineWidth));
    
    //填充
    CGContextSetFillColorWithColor(context, [UIColor orangeColor].CGColor);
    CGContextEOFillPath(context);
    

    //生成新的image
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;

}
@end
