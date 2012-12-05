//
//  HappinessViewController.m
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

// Declare that I am implementing the @protocol FaceViewDataSource
@interface HappinessViewController () <FaceViewDataSource>
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
    // This watches for a pinch gesture and sends a message when it occurs
    [self.faceView addGestureRecognizer:[[UIPinchGestureRecognizer alloc]
                                         initWithTarget:self.faceView
                                         action:@selector(pinch:)]];
    [self.faceView addGestureRecognizer:[[UIPanGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:
                                         @selector(handleHappinessGesture:)]];
    self.faceView.dataSource = self; // This is ok because self implements this
}

- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;  // Decrease sensitivity
        // We want incremental changes, so reset
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

- (float)smileForFaceView:(FaceView *)sender {
    return (self.happiness - 50) / 50.0; // Make it a float
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)
toInterfaceOrientation {
    return YES;
}

@end
