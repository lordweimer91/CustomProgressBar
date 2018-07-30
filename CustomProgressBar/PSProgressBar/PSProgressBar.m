//
//  PSProgressBar.m
//  CustomProgressBar
//
//  Created by user on 24.07.18.
//  Copyright © 2018 user. All rights reserved.
//

#import "PSProgressBar.h"

@interface PSProgressBar()

@property (nonatomic, assign) IBInspectable CGFloat lineWidth;
@property (nonatomic, assign) IBInspectable CGFloat angle;
@property (nonatomic, strong) IBInspectable UIColor *progressColor;
@property (nonatomic, strong) IBInspectable UIColor *fontColor;
@property (nonatomic, strong) IBInspectable UIColor *shapeColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic ,assign) IBInspectable CGFloat numberOfSegment;

@end

@implementation PSProgressBar

-(UIBezierPath *) createCirclePathWithAngle: (CGFloat) angle
                                  lineWidth: (CGFloat) lineWidth
                                borderWidth: (CGFloat) borderWidth
                                   progress: (CGFloat) progress
                                 shapeColor: (UIColor *) shapeColor
                              progressColor: (UIColor *) progressColor
{
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint center = CGPointMake(x, y);
    CGFloat angleRadian = angle * M_PI / 360.0f;
    CGFloat progressAngle = 2.0f * (M_PI - angleRadian) * progress;
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath addArcWithCenter: center
                          radius: (MIN(x, y) - (lineWidth / 2.0f) - borderWidth)
                      startAngle: M_PI_2 + angleRadian + progressAngle
                        endAngle: M_PI_2 - angleRadian
                       clockwise: YES];
    if(shapeColor == nil){
        [[UIColor colorWithHue: (progress / 3.0f)
                    saturation: 1.0f
                    brightness: 1.0f
                         alpha: 1.0f] setStroke];
    } else {
        [shapeColor setStroke];
    }
    bezierPath.lineWidth = lineWidth - borderWidth;
    [bezierPath stroke];
    
    [bezierPath removeAllPoints];
    [bezierPath addArcWithCenter: center
                          radius: (MIN(x, y) - (lineWidth / 2.0f) - borderWidth)
                      startAngle: angleRadian + M_PI_2
                        endAngle: progressAngle + angleRadian + M_PI_2
                       clockwise: YES];
    [progressColor setStroke];
    [bezierPath stroke];
    
    return bezierPath;
}

-(UIBezierPath *) segmentPathWithSegmentNumber: (NSUInteger) number
                                         angle: (CGFloat) angle
                                         width: (CGFloat) width
                                   borderWidth: (CGFloat) borderWidth
                                   borderColor: (UIColor *) borderColor
{
    const CGFloat kAngleOffset = 0.01f;
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint center = CGPointMake(x, y);
    CGFloat radius = MIN(x , y) - borderWidth;
    CGFloat angleRadian = angle * M_PI / 360.0f;
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath addArcWithCenter: center
                          radius: radius
                      startAngle: M_PI_2 + angleRadian - kAngleOffset
                        endAngle: M_PI_2 - angleRadian + kAngleOffset
                       clockwise: YES];
    [bezierPath addArcWithCenter: center
                          radius: radius - width
                      startAngle: M_PI_2 - angleRadian + kAngleOffset
                        endAngle: M_PI_2 + angleRadian - kAngleOffset
                       clockwise: NO];
    [bezierPath closePath];
    
    for (NSUInteger i = 1; i < number; i++) {
        CGFloat angleSegment = M_PI_2 - angleRadian - (2.0f * (M_PI - angleRadian) / number * i);
        CGPoint startPoint = CGPointMake(center.x + ((radius) * cosf(angleSegment)),
                                         center.y + ((radius) * sinf(angleSegment)));
        CGPoint endPoint = CGPointMake(center.x + ((radius - width) * cosf(angleSegment)),
                                       center.y + ((radius - width) * sinf(angleSegment)));
        [bezierPath moveToPoint: startPoint];
        [bezierPath addLineToPoint: endPoint];
    }
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    return bezierPath;
    
}

-(void)simpleShape
{
    if(self.lineWidth > (MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) / 2.0f)){
        self.lineWidth = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) / 2.0f;
    } else if(self.lineWidth < 0) {
        self.lineWidth = 0;
    }
    
    [self createCirclePathWithAngle: self.angle
                          lineWidth: (self.lineWidth)
                        borderWidth: (self.borderWidth / 100.0f)
                           progress: self.progress
                         shapeColor: self.shapeColor
                      progressColor: self.progressColor];
    [self segmentPathWithSegmentNumber: self.numberOfSegment
                                 angle: self.angle
                                 width: self.lineWidth
                           borderWidth: self.borderWidth / 100.0f
                           borderColor: self.borderColor];
    
    CATextLayer *textLayer = [CATextLayer new];
    textLayer.string = [NSString stringWithFormat: @"%0.f", self.progress * 100.0f];
    textLayer.foregroundColor = self.fontColor.CGColor;
    CGFloat fontSize = (MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds)) - (self.lineWidth * 2.0f)) / 2.0f;
    textLayer.frame = CGRectMake(CGRectGetMidX(self.bounds) - fontSize,
                                 CGRectGetMidY(self.bounds) - (fontSize / 2.0f),
                                 fontSize * 2.0f,
                                 fontSize);
    textLayer.fontSize = fontSize;
    [textLayer setFont: @"ArialMT"];
    textLayer.alignmentMode = @"center";
    
    if(self.layer.sublayers.count){
        [[self.layer.sublayers copy] makeObjectsPerformSelector: @selector(removeFromSuperlayer)];
    }
    [self.layer addSublayer: textLayer];
}

-(void) setProgress:(CGFloat)progress
{
    if(progress > 100){
        progress = 100.0f;
    } else if(progress <= 0) {
        progress = 0;
    }
    _progress = progress / 100.0f;
    [self setNeedsLayout];
}

-(void) setAngle:(CGFloat)angle
{
    if(angle > 180.0f){
        angle = 180.0f;
    } else if(angle < 0){
        angle = 0;
    }
    _angle = angle;
}

-(void) drawRect:(CGRect)rect
{
    [self simpleShape];
}

@end
