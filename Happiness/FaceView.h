//
//  FaceView.h
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceView : UIView
@property (nonatomic) CGFloat scale;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end