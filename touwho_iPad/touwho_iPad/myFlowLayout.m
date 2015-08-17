//
//  myFlowLayout.m
//  touwho_iPad
//
//  Created by apple on 15/8/13.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

#import "myFlowLayout.h"
#import "CATransform3DPerspect.h"


#define ACTIVE_DISTANCE 550
#define CELL_DISTANCE 80

@implementation myFlowLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        self.sectionInset = UIEdgeInsetsMake(200, 0.0, 200, 0.0);
        self.minimumLineSpacing = -40.0;
    }
    return self;
}

//-(id)init
//{
//    self = [super init];
//    if (self) {
//        self.itemSize = CGSizeMake(ITEM_SIZE, 200);
//        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//        self.sectionInset = UIEdgeInsetsMake(200, 0.0, 200, 0.0);
//        self.minimumLineSpacing = -400.0;
//    }
//    return self;
//}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                
                CGFloat zoom = 1 - ABS(normalizedDistance);
<<<<<<< HEAD
//                NSLog(@"%f",zoom);
//
                //在左半边
=======
                NSLog(@"%f",zoom);
>>>>>>> parent of b4066f9... 图片滚动仿网易云音乐成功
                if (distance > 0) {
                    CATransform3D rotate = CATransform3DMakeRotation((1-zoom)*M_PI/7, 0, 1, 0);
                    
                    attributes.transform3D = rotate;
                    CGFloat zoom2 = zoom +0.8;
                    if (zoom2 < 1.4) {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,zoom2);
                    }
                    else {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,1.4);
                    }
                    
                    
                    
                    attributes.zIndex = 1;
                }
                else {
                    CATransform3D rotate = CATransform3DMakeRotation((zoom-1)*M_PI/7, 0, 1, 0);
                    
                    attributes.transform3D = rotate;
                    
                    CGFloat zoom2 = zoom +0.8;
                    if (zoom2 < 1.4) {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,zoom2);
                    }
                    else {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,1.4);
                    }
                    
                    attributes.zIndex = 1;
                }
                
            }
            else{
                [UIView animateWithDuration:1 animations:^{
                    attributes.transform3D = CATransform3DIdentity;
                }];
            }
        }
    }
    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);
}

@end