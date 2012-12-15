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
@interface HappinessViewController () <FaceViewDataSource,
UISplitViewControllerDelegate>
@property (nonatomic) IBOutlet FaceView *faceView;
@property (nonatomic) IBOutlet UIToolbar *toolbar;
@end

@implementation HappinessViewController
@synthesize splitViewBarButtonItem = _splitViewBarButtonItem;

- (void)setSplitViewBarButtonItem:(UIBarButtonItem *)splitViewBarButtonItem {
    if (_splitViewBarButtonItem != splitViewBarButtonItem) {
        NSMutableArray *toolbarItems = [self.toolbar.items mutableCopy];
        if (_splitViewBarButtonItem) {
            [toolbarItems removeObject:_splitViewBarButtonItem];
        }
        if (splitViewBarButtonItem) {
            [toolbarItems insertObject:splitViewBarButtonItem atIndex:0];
        }
        self.toolbar.items = toolbarItems;
        _splitViewBarButtonItem = splitViewBarButtonItem;
    }
}

- (void)setHappiness:(int)happiness {
    _happiness = happiness;
    [self.faceView setNeedsDisplay]; // redraw view on happiness set
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

// Change the happiness of the face based on the swipe
- (void)handleHappinessGesture:(UIPanGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        CGPoint translation = [gesture translationInView:self.faceView];
        self.happiness -= translation.y / 2;  // Decrease sensitivity
        // We want incremental changes, so reset
        [gesture setTranslation:CGPointZero inView:self.faceView];
    }
}

// Convert the data from the model's format
- (float)smileForFaceView:(FaceView *)sender {
    return (self.happiness - 50) / 50.0; // Make it a float
}

@end
