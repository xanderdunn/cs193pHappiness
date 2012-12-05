//
//  FaceView.h
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import <UIKit/UIKit.h>

// Forward reference
@class FaceView; // There is a class called FaceView defined somewhere

// We are delegating the soure of the data for the view
// A view must delegate the source of its data, because it can't own it
@protocol FaceViewDataSource
// This is a protocol because someone else will implement the data source.
//  Here we will simply use it.

- (float)smileForFaceView:(FaceView *)sender;
// A delegation almost always passes itself as a sender so that questions can
//  be asked

@end

@interface FaceView : UIView
@property (nonatomic) CGFloat scale;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;

@end