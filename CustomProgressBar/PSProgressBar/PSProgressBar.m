//
//  PSProgressBar.m
//  CustomProgressBar
//
//  Created by user on 24.07.18.
//  Copyright © 2018 user. All rights reserved.
//

#import "PSProgressBar.h"

@interface PSProgressBar()

@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, assign) IBInspectable CGFloat lineWidth;
@property (nonatomic, assign) IBInspectable CGFloat angle;
@property (nonatomic, strong) IBInspectable UIColor *progressColor;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, strong) IBInspectable UIColor *fontColor;
@property (nonatomic, assign) CGFloat progressKoeficient;
@property (nonatomic, strong) IBInspectable UIColor *shapeColor;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end

@implementation PSProgressBar

-(UIBezierPath *) createCirclePathWithAngle: (CGFloat)angle
                                  lineWidth: (CGFloat)lineWidth
{
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint center = CGPointMake(x, y);
    CGFloat angleRadian = angle * M_PI / 360.0f;
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath addArcWithCenter: center
                               radius: (MIN(x, y) - (lineWidth / 2.0f))
                           startAngle: angleRadian + M_PI_2
                             endAngle: (M_PI * (2.5f) + angleRadian)
                            clockwise: YES];
    return bezierPath;
}

-(UIBezierPath *) segmentPathWithSegmentNumber: (NSUInteger)number
                                         angle: (CGFloat)angle
                                         width: (CGFloat)width
{
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint center = CGPointMake(x, y);
    CGFloat radius = MIN(x, y);
    CGFloat angleRadian = angle * M_PI / 360.0f;
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath addArcWithCenter: center
                          radius: radius
                      startAngle: M_PI_2 + angleRadian
                        endAngle: ((M_PI * 2.5f) - angleRadian)
                       clockwise: YES];
    CGPoint point = CGPointMake(center.x + ((radius - width) * cosf(M_PI_2 - angleRadian)),
                                center.y + ((radius - width) * sinf(M_PI_2 - angleRadian)));
    [bezierPath addLineToPoint: point];
    [bezierPath addArcWithCenter: center
                          radius: radius - width
                      startAngle: M_PI_2 - angleRadian
                        endAngle: (M_PI * (2.5f) + angleRadian)
                       clockwise: NO];
    [bezierPath closePath];
    
    for (NSUInteger i = 1; i < number; i++) {
        CGFloat angle = M_PI_2 - angleRadian - (2.0f * (M_PI - angleRadian) / number * i);
        CGPoint startPoint = CGPointMake(center.x + ((radius) * cosf(angle)),
                                         center.y + ((radius) * sinf(angle)));
        CGPoint endPoint = CGPointMake(center.x + ((radius - width) * cosf(angle)),
                                       center.y + ((radius - width) * sinf(angle)));
        [bezierPath moveToPoint: startPoint];
        [bezierPath addLineToPoint: endPoint];
    }
    
    return bezierPath;
}

-(void)simpleShape
{
    if(self.lineWidth > (MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) / 2.0f)){
        self.lineWidth = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds)) / 2.0f;
    }
    if(self.layer.sublayers.count){
        [[self.layer.sublayers copy] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    }
    self.progressKoeficient = (1.0f - (self.angle / 360.0f)) / 100.0f;
    
    UIBezierPath *bezierPath = [self createCirclePathWithAngle: self.angle
                                                     lineWidth: self.lineWidth];
    if(self.shapeLayer == nil){
        self.shapeLayer = [CAShapeLayer new];
    }
    self.shapeLayer.path = bezierPath.CGPath;
    self.shapeLayer.lineWidth = self.lineWidth;
    self.shapeLayer.fillColor = nil;
    if(self.shapeColor == nil){
        self.shapeLayer.strokeColor = [UIColor colorWithHue: (self.progress / 300.0f)
                                                 saturation: 1.0f
                                                 brightness: 1.0f
                                                      alpha: 1.0f].CGColor;
    } else {
        self.shapeLayer.strokeColor = self.shapeColor.CGColor;
    }
    self.shapeLayer.strokeEnd = self.progressKoeficient * 100.0f;
    [self.layer addSublayer: self.shapeLayer];

    
    if(self.progressLayer == nil){
        self.progressLayer = [CAShapeLayer new];
    }
    self.progressLayer.path = [self createCirclePathWithAngle:self.angle
                                               lineWidth:self.lineWidth].CGPath;
    self.progressLayer.lineWidth = self.lineWidth;
    self.progressLayer.lineCap = kCALineCapButt;
    self.progressLayer.fillColor = nil;
    self.progressLayer.strokeColor = self.progressColor.CGColor;
    self.progressLayer.strokeEnd = self.progress  * self.progressKoeficient;
    
    CAShapeLayer *borderLayer = [CAShapeLayer new];
    borderLayer.path = [self segmentPathWithSegmentNumber: 10
                                                    angle: self.angle
                                                    width: self.lineWidth].CGPath;
    borderLayer.lineWidth = self.lineWidth / 20.0f;
    borderLayer.fillColor = nil;
    borderLayer.strokeColor = self.borderColor.CGColor;
    
    self.textLayer = [CATextLayer new];
    self.textLayer.string = [NSString stringWithFormat: @"%0.f", self.progress];
    self.textLayer.foregroundColor = self.fontColor.CGColor;
    self.fontSize = (MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds)) - (self.lineWidth * 2.0f)) / 2.0f;
    self.textLayer.frame = CGRectMake(CGRectGetMidX(self.bounds) - (self.fontSize),
                                      CGRectGetMidY(self.bounds) - (self.fontSize / 2.0f),
                                      self.fontSize * 2.0f,
                                      self.fontSize);
    self.textLayer.fontSize = self.fontSize;
    [self.textLayer setFont: @"ArialMT"];
    self.textLayer.alignmentMode = @"center";
    
    [self.layer addSublayer: borderLayer];
    [self.layer addSublayer: self.progressLayer];
    [self.layer addSublayer: self.textLayer];
}

-(void) setProgress:(CGFloat)progress
{
    if(progress > 100){
        progress = 100.0f;
    } else if(progress <= 0) {
        progress = 0;
        _progressLayer.speed = 1000.0f;
    } else {
        _progressLayer.speed = 1.0f;
    }
    _progress = progress;
    _progressLayer.strokeEnd = progress * _progressKoeficient;
    _textLayer.string = [NSString stringWithFormat: @"%0.f", _progress];
    if(_shapeColor == nil){
        _shapeLayer.strokeColor = [UIColor colorWithHue: (_progress / 300.0f)
                                             saturation: 1.0f
                                             brightness: 1.0f
                                                  alpha: 1.0f].CGColor;
    }
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
