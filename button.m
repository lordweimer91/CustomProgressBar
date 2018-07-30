//
//  button.m
//  CustomProgressBar
//
//  Created by user on 26.07.18.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "button.h"

@interface button()
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@end

@implementation button


-(void) awakeFromNib
{
    [super awakeFromNib];
    _gradientLayer = [CAGradientLayer new];
    _gradientLayer.bounds = self.bounds;
    _gradientLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    [self.layer insertSublayer:_gradientLayer atIndex:0];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    self.gradientLayer.colors = [NSArray arrayWithObjects:(id)UIColor.greenColor.CGColor, (id)UIColor.blueColor.CGColor, nil];
}


@end
