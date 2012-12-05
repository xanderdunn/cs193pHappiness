//
//  HappinessViewController.m
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController ()
@property (nonatomic) IBOutlet FaceView *faceView;
@end

@implementation HappinessViewController

- (void)setHappiness:(int)happiness {
    _happiness = happiness;
    [self.faceView setNeedsDisplay]; // redraw view on happiness set
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// When the FaceView UIView is created, now is a good time to create the
//  gesture recognizer
- (void)setFaceView:(FaceView *)faceView {
    _faceView = faceView;
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                         initWithTarget:self.faceView
                                         action:@selector(pinch:)]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)
toInterfaceOrientation {
    return YES;
}

@end
