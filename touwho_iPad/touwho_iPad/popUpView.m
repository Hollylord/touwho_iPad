//
//  popUpView.m
//  ad
//
//  Created by apple on 15/8/4.
//  Copyright (c) 2015年 touwho. All rights reserved.
//

#import "popUpView.h"
#define kArrorHeight    10

@implementation popUpView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor clearColor];
        UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"biaoqian"]];
        [self addSubview:background];
        
        self.activityName = [[UILabel alloc] init];
        self.activityName.frame = CGRectMake(30, 10, 250, 20);
        self.activityName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.activityName];
        
        self.time = [[UILabel alloc] init];
        self.time.numberOfLines = 0;
        self.time.textAlignment = NSTextAlignmentNatural;
        self.time.font = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        [self addSubview:self.time];
        
        
        
        
        self.place = [[UILabel alloc] init];
        [self addSubview:self.place];
        
    }
    return self;
}
- (void)setModel:(ModelMap *)model{
    if (_model != model) {
        _model = model;
        
    }
    self.activityName.text = model.activtyName;
    self.time.text = model.time;
    //通过字体动态计算高度
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:self.time.font forKey:NSFontAttributeName];
    CGSize timeSize = [self.time.text boundingRectWithSize:CGSizeMake(150, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.time.frame = CGRectMake(30, 50, 250, timeSize.height);
    
    self.place.text = model.place;
    //通过字体计算label高度
    NSDictionary *attribute = [NSDictionary dictionaryWithObject:self.place.font forKey:NSFontAttributeName];
    CGSize placeSize = [self.place.text boundingRectWithSize:CGSizeMake(250, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    self.place.frame = CGRectMake(30, 120, 250, placeSize.height);
    
}

//#pragma mark - draw rect
//
//- (void)drawRect:(CGRect)rect
//{
//    
//    [self drawInContext:UIGraphicsGetCurrentContext()];
//    
//    self.layer.shadowColor = [[UIColor blackColor] CGColor];
//    self.layer.shadowOpacity = 1.0;
//    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
//    
//}
//
//- (void)drawInContext:(CGContextRef)context
//{
//    
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
//    
//    [self getDrawPath:context];
//    CGContextFillPath(context);
//    
//}
//
//- (void)getDrawPath:(CGContextRef)context
//{
//    CGRect rrect = self.bounds;
//    CGFloat radius = 6.0;
//    CGFloat minx = CGRectGetMinX(rrect),
//    midx = CGRectGetMidX(rrect),
//    maxx = CGRectGetMaxX(rrect);
//    CGFloat miny = CGRectGetMinY(rrect),
//    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
//    
//    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
//    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
//    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
//    
//    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
//    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
//    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
//    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
//    CGContextClosePath(context);
//}




@end
