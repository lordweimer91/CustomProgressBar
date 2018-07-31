//
//  GraphView.m
//  CustomProgressBar
//
//  Created by user on 30.07.18.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "GraphView.h"

/*
 static  let cornerRadiusSize = CGSize (width: 8.0 , height: 8.0 )
 static  let margin: CGFloat = 20.0
 static  let topBorder: CGFloat = 60
 static  let bottomBorder: CGFloat = 50
 static  let colorAlpha: CGFloat = 0.3
 static  let circleDiameter: CGFloat = 5.0
 */

/*static const CGFloat margin = 20.0f;
static const CGFloat topBorder = 60.0f;
static const CGFloat bottomBorder = 50.0f;
static const CGFloat colorAlpha = 0.0f;
static const CGFloat circleDiametr = 5.0f;*/
static const CGFloat cornerRadius = 10.0f;


IB_DESIGNABLE
@interface GraphView()

@property (nonatomic, strong) IBInspectable UIColor *firstColor;
@property (nonatomic, strong) IBInspectable UIColor *secondColor;


@end

@implementation GraphView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect
                                               byRoundingCorners:UIRectCornerAllCorners
                                                     cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [path addClip];
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat red = 0, green = 0, blue = 0, alpha = 0;
    CGFloat red2 = 0, green2 = 0, blue2 = 0, alpha2 = 0;
    [self.firstColor getRed:&red
                      green:&green
                       blue:&blue
                      alpha:&alpha];
    [self.secondColor getRed:&red2
                       green:&green2
                        blue:&blue2
                       alpha:&alpha2];
    CGFloat colors[] = {red, green, blue, alpha, red2, green2, blue2, alpha2};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colorLocation[] = {0.0, 1.0};
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, colorLocation, 2);
    CGPoint startPoint = CGPointZero;
    CGPoint endPoint = CGPointMake(0.0f, self.bounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation);
}


@end
