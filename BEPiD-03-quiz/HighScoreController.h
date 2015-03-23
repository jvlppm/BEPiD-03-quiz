//
//  HighScoreViewController.h
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"

@interface HighScoreController : NSObject<UITableViewDataSource, UITableViewDelegate>

+ (void) showViewReseting: (BOOL) backToRoot fromController: (UIViewController*) fromVC;

@property int markScore;

@end
