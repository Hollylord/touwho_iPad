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
#define CELL_DISTANCE 200

@implementation myFlowLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.minimumLineSpacing = -20.0;
        self.itemSize = CGSizeMake(401, 148);
        
    }
    return self;
}


- (void)prepareLayout{
    
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}


//rect是scrollview的rect，即它的contentoffset会随着滚动变化，不是0，0
-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            
            if (ABS(distance) < 300) {
                attributes.zIndex = 1;
            }
            else {
                attributes.zIndex = -1;
            }
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
                
                CGFloat zoom = 1 - ABS(normalizedDistance);
              
                //在左半边
                if (distance > 0) {
                    //                    //旋转的角度控制(1-zoom)*M_PI/6
                    CATransform3D rotate = CATransform3DMakeRotation((1-zoom)*M_PI/6, 0, 1, 0);
                    
                    //                    attributes.transform3D = rotate;
                    CGFloat zoom2 = zoom/2+0.8 ;
                    if (zoom2 < 1) {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,1);
                    }
                   
                    else {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,zoom2);
                    }
   

                }
                //在右半边
                else {
                    //(zoom-1)*M_PI/6
                    CATransform3D rotate = CATransform3DMakeRotation((zoom-1)*M_PI/6, 0, 1, 0);
                    
 
                    
                    CGFloat zoom2 = zoom/2+0.8;
                    if (zoom2 < 1) {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,1);
                    }
                    else {
                        attributes.transform3D = CATransform3DPerspect(rotate, CGPointMake(0,0.5), CELL_DISTANCE,zoom2);
                    }
                    
                    
                    

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


/**
 *  返回collectionView最终的偏移量（最终的停留位置）
 *
 *  @param proposedContentOffset 默认情况下，预测collectionView最终的contentOffset
 *  @param velocity              <#velocity description#>
 *
 *  @return <#return value description#>
 */
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