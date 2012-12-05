//
//  FaceView.m
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

// FIXME: WHY do I need this!?  I didn't need it in CalculatorBrain.m
@synthesize scale = _scale;

#define DEFAULT_SCALE 0.90

- (CGFloat)scale {
    if (!_scale) return DEFAULT_SCALE;
    else return _scale;
}

- (void)setScale:(CGFloat)scale {
    if (scale != _scale) { // setNeedsDisplay is expense, check for change
        _scale = scale;
        [self setNeedsDisplay]; // If scale changed, update display
    }
}

- (void)setup { // redraw 
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setup]; // redraw on load
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup]; // redraw on init
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius
                inContext:(CGContextRef)context { // create a standard circle
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, p.x, p.y, radius, 0, 2*M_PI, YES);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

#define EYE_H 0.35
#define EYE_V 0.35
#define EYE_RADIUS 0.10
#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25

- (void)drawRect:(CGRect)rect
{
    // Anytime drawing is done, we need the context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Mouth definitions
    CGPoint midPoint;
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width/2;
    if (self.bounds.size.height < self.bounds.size.width) { // 
        size = self.bounds.size.height/2;
    }
    size *= self.scale;
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    // Draw the face circle
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context];
    
    // Eye definitions 
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYE_H;
    eyePoint.y = midPoint.y - size * EYE_V;
    
    // Draw the eye circles
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS
                  inContext:context];
    eyePoint.x += size *  EYE_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:size * EYE_RADIUS
                  inContext:context];
    
    // Mouth definitions
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * size * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += (mouthEnd.x - mouthStart.x)/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= (mouthEnd.x - mouthStart.x)/3;
    
    float smile = 0;
    
    // Curve offset
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    
    // Draw the mouth
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    // The control point y values are always the same
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP1.y, mouthCP2.x,
                             mouthCP1.y, mouthEnd.x, mouthEnd.y);
    CGContextStrokePath(context);
}

// Pinch to scale the face
- (void)pinch:(UIPinchGestureRecognizer *)gesture {
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
         (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale;
        gesture.scale = 1; // reset the gesture to 1
    }
}

@end
