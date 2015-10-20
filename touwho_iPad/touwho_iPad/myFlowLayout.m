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
{
    CGFloat itemCenterx;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        //-20
        self.minimumLineSpacing = -20.0;
        self.itemSize = CGSizeMake(400, 148);
        
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
    
    //当下可视范围
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    NSArray *visibleItemAttr = [super layoutAttributesForElementsInRect:visibleRect];

    //获得中间item的centerX
    UICollectionViewLayoutAttributes* attrCenterItem = [visibleItemAttr objectAtIndex:1];
    itemCenterx = attrCenterItem.center.x;
    
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
                    //                    旋转的角度控制(1-zoom)*M_PI/6
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
 *  这个方法是当手指离开的那一刻才调用， 不是手指一滑就调用。
 *  @param proposedContentOffset 默认情况下，预测collectionView最终的contentOffset
 *  @param velocity              velocity description
 *
 *  @return <#return value description#>
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
 
    CGPoint currentContentOffset = self.collectionView.contentOffset;
    //偏移量：也就是手指滑动的距离
    CGFloat delta = currentContentOffset.x + self.collectionView.bounds.size.width*0.5 - itemCenterx;
    //往左滑
    if (proposedContentOffset.x < currentContentOffset.x) {
        if (ABS(delta) <= 30) {
            return CGPointMake(currentContentOffset.x - delta , proposedContentOffset.y);
        }
        else if (ABS(delta) > 30 &&  itemCenterx - currentContentOffset.x > 284 )
        {
            return CGPointMake(currentContentOffset.x - (delta+380) , proposedContentOffset.y);
        }
        else{
            return CGPointMake(currentContentOffset.x - delta , proposedContentOffset.y);
        }
    }
    //往右滑
    else {
        if (ABS(delta) <= 10) {
            return CGPointMake(currentContentOffset.x - delta , proposedContentOffset.y);
        }
        else if (ABS(delta) > 10 &&  itemCenterx - currentContentOffset.x > 284 )
        {
            return CGPointMake(currentContentOffset.x - (delta-380) , proposedContentOffset.y);
        }
        else{
            return CGPointMake(currentContentOffset.x - delta , proposedContentOffset.y);
        }
    }

    
}


@end