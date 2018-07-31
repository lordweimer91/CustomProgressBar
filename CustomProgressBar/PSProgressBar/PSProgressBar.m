//
//  PSProgressBar.m
//  CustomProgressBar
//
//  Created by user on 24.07.18.
//  Copyright © 2018 user. All rights reserved.
//

#import "PSProgressBar.h"

@interface PSProgressBar()

@property (nonatomic, assign) IBInspectable CGFloat angle;
@property (nonatomic ,assign) IBInspectable CGFloat numberOfSegment;

@property (nonatomic, strong) IBInspectable UIColor *colorProgress;
@property (nonatomic, strong) IBInspectable UIColor *colorFont;
@property (nonatomic, strong) IBInspectable UIColor *colorShape;
@property (nonatomic, strong) IBInspectable UIColor *colorBorder;

@property (nonatomic, assign) IBInspectable CGFloat widthArcKoef;
@property (nonatomic, assign) IBInspectable CGFloat widthProgressLineKoef;
@property (nonatomic, assign) IBInspectable CGFloat widthMarkerKoef;
@property (nonatomic, assign) IBInspectable CGFloat lengthMarkerKoef;
@property (nonatomic, assign) IBInspectable CGFloat lengthProgressLineKoef;
@end

@implementation PSProgressBar
/*
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
                      startAngle: M_PI_2 + angleRadian// + progressAngle
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
    //[bezierPath stroke];
    
    return bezierPath;
}

-(void) segmentPathWithSegmentNumber: (NSUInteger) number
                                         angle: (CGFloat) angle
                                         width: (CGFloat) width
                                   borderWidth: (CGFloat) borderWidth
                                   borderColor: (UIColor *) borderColor
                                          rect: (CGRect) rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [borderColor setFill];
    CGFloat markerSize = 10.0f;
    UIBezierPath *markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-borderWidth / 2.0f,
                                                                           0,
                                                                           borderWidth,
                                                                           markerSize)];
    CGContextTranslateCTM(context, rect.size.width / 2.0f, rect.size.height / 2.0f);
    
    CGContextSaveGState(context);
    CGFloat angleRadian = angle * M_PI / 360.0f;
    CGFloat angleDifference = 2.0f * (M_PI - angleRadian);
    CGFloat arcLengthPerGlass = angleDifference / number;
    
    for (NSInteger i = 0; i <= number; i++) {
        CGContextSaveGState(context);
        CGFloat angleSegment = arcLengthPerGlass * i  + angleRadian;
        CGContextRotateCTM(context, angleSegment);
        CGContextTranslateCTM(context, 0, rect.size.height / 2.0f - markerSize);
        [markerPath fill];
        CGContextRestoreGState(context);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-borderWidth / 2.0f, 0, borderWidth, width)];
    CGFloat progressAngle = angleDifference * self.progress + angleRadian;
    CGContextRotateCTM(context, progressAngle);
    CGContextTranslateCTM(context, 0, rect.size.height / 2.0f - width);
    [self.progressColor setFill];
    [markerPath fill];
    CGContextRestoreGState(context);
}

-(void)simpleShapeInRect:(CGRect) rect
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
                           borderColor: self.borderColor
                                  rect: rect];
    
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
*/
-(void) setProgress:(CGFloat)progress
{
    if(progress > 100){
        progress = 100.0f;
    } else if(progress <= 0) {
        progress = 0;
    }
    _progress = progress;
    [self setNeedsDisplay];
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
    CGFloat koef = MIN(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGFloat widthArc = koef * self.widthArcKoef;
    
    CGFloat lengthMarker = koef * self.lengthMarkerKoef;
    CGFloat lengthProgressLine = koef * self.lengthProgressLineKoef;
    CGFloat widthProgressLine = koef * self.widthProgressLineKoef;
    CGFloat widthMarker = koef * self.widthMarkerKoef;
    
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint center = CGPointMake(x, y);
    CGFloat angleRadian = self.angle * M_PI / 360.0f;
    UIBezierPath *bezierPath = [UIBezierPath new];
    [bezierPath addArcWithCenter: center
                          radius: (MIN(x, y) - (widthArc / 2.0f))
                      startAngle: M_PI_2 + angleRadian
                        endAngle: M_PI_2 - angleRadian
                       clockwise: YES];
    if(self.colorShape == nil){
        [[UIColor colorWithHue: (self.progress / 300.0f)
                    saturation: 1.0f
                    brightness: 1.0f
                         alpha: 1.0f] setStroke];
    } else {
        [self.colorShape setStroke];
    }
    bezierPath.lineWidth = widthArc;
    [bezierPath stroke];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    [self.colorBorder setFill];
    UIBezierPath *markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-widthMarker / 2.0f,
                                                                           0,
                                                                           widthMarker,
                                                                           lengthMarker)];
    CGContextTranslateCTM(context, rect.size.width / 2.0f, rect.size.height / 2.0f);
    
    CGContextSaveGState(context);
    CGFloat angleDifference = 2.0f * (M_PI - angleRadian);
    CGFloat arcLengthPerGlass = angleDifference / self.numberOfSegment;
    
    for (NSInteger i = 0; i <= self.numberOfSegment; i++) {
        CGContextSaveGState(context);
        CGFloat angleSegment = arcLengthPerGlass * i  + angleRadian;
        CGContextRotateCTM(context, angleSegment);
        CGContextTranslateCTM(context, 0, MIN(rect.size.height, rect.size.width) / 2.0f - lengthMarker);
        [markerPath fill];
        CGContextRestoreGState(context);
    }
    CGContextRestoreGState(context);
    
    CGContextSaveGState(context);
    markerPath = [UIBezierPath bezierPathWithRect:CGRectMake(-widthProgressLine / 2.0f,
                                                             0,
                                                             widthProgressLine,
                                                             lengthProgressLine)];
    CGFloat progressAngle = angleDifference * self.progress / 100.0f + angleRadian;
    CGContextRotateCTM(context, progressAngle);
    CGContextTranslateCTM(context, 0, MIN(rect.size.height, rect.size.width) / 2.0f - lengthProgressLine);
    [self.colorProgress setFill];
    [markerPath fill];
    CGContextRestoreGState(context);
    
    CATextLayer *textLayer = [CATextLayer new];
    textLayer.string = [NSString stringWithFormat: @"%0.f", self.progress];
    textLayer.foregroundColor = self.colorFont.CGColor;
    CGFloat fontSize = (MIN(CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds)) - (widthArc * 2.0f)) / 2.0f;
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

@end
