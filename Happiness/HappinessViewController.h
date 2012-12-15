//
//  HappinessViewController.h
//  Happiness
//
//  Created by admin on 3/D/12.
//  Copyright (c) 2012 ThoughtAdvances. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplitViewBarButtonItemPresenter.h"

@interface HappinessViewController : UIViewController
<SplitViewBarButtonItemPresenter>
@property (nonatomic) int happiness; // 0 is sad, 100 is happy
@end
