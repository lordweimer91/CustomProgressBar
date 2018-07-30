//
//  PushButton.m
//  CustomProgressBar
//
//  Created by user on 30.07.18.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "PushButton.h"

static const CGFloat plusLineWidth = 3.0f;
static const CGFloat plusButtonScale = 0.6f;
static const CGFloat halfPointShift = 0.3f;

@interface PushButton()
@property (nonatomic, strong) IBInspectable UIColor *fillColor;
@property (nonatomic, assign) IBInspectable BOOL isAddButton;
@end

@implementation PushButton

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [self.fillColor setFill];
    [path fill];
    
    CGFloat plusWidth = MIN(self.bounds.size.height, self.bounds.size.width) * plusButtonScale;
    UIBezierPath *plusPath = [UIBezierPath bezierPath];
    plusPath.lineWidth = plusLineWidth;
    
    [plusPath moveToPoint:CGPointMake(((self.bounds.size.width - plusWidth) / 2.0f) + halfPointShift,
                                      (self.bounds.size.height / 2.0f) + halfPointShift)];

    [plusPath addLineToPoint:CGPointMake(((self.bounds.size.width + plusWidth) / 2.0f) + halfPointShift,
                                        (self.bounds.size.height / 2.0f) + halfPointShift)];
    if(self.isAddButton) {
        [plusPath moveToPoint:CGPointMake(((self.bounds.size.width) / 2.0f) + halfPointShift,
                                          ((self.bounds.size.height - plusWidth) / 2.0f) + halfPointShift)];
        
        [plusPath addLineToPoint:CGPointMake(((self.bounds.size.width) / 2.0f) + halfPointShift,
                                             ((self.bounds.size.height  + plusWidth) / 2.0f) + halfPointShift)];
    }
    [UIColor.whiteColor setStroke];
    [plusPath stroke];

}


@end
