//
//  ViewController.m
//  CustomProgressBar
//
//  Created by user on 26.07.18.
//  Copyright © 2018 Sibers. All rights reserved.
//

#import "ViewController.h"
#import "ContainerView.h"
#import "PSProgressBar.h"
#import "GraphView.h"
#import "PushButton.h"

@interface ViewController () //: <UIGestureRecognizerDelegate>

@property (nonatomic, weak) IBOutlet ContainerView *containerView;
@property (nonatomic, weak) IBOutlet PSProgressBar *progressBar;
@property (nonatomic, weak) IBOutlet GraphView *graphView;
@property (nonatomic, weak) IBOutlet PushButton *plusButton;

@property (nonatomic, assign) BOOL isGraphViewShowing;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressBar.progress = 0;
}


- (IBAction)counterViewTap:(UITapGestureRecognizer *)sender
{
    if(self.isGraphViewShowing){
        [UIView transitionFromView: self.graphView
                            toView: self.progressBar
                          duration: 1.0f
                           options: (UIViewAnimationOptionTransitionFlipFromLeft | UIViewAnimationOptionShowHideTransitionViews)
                        completion: nil];
    } else {
        [UIView transitionFromView:self.progressBar
                            toView:self.graphView
                          duration:1.0f
                           options:(UIViewAnimationOptionTransitionFlipFromRight | UIViewAnimationOptionShowHideTransitionViews)
                        completion:nil];
    }
    self.isGraphViewShowing = !self.isGraphViewShowing;
}

- (IBAction)didTapPlusButton:(id)sender
{
    self.progressBar.progress ++;
}

- (IBAction)didTapMinusButton:(id)sender
{
    self.progressBar.progress--;
}

@end
