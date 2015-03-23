//
//  TableViewController.h
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UIViewController

@property (nonatomic) UIImage* bgImage;

- (void) setBackToRoot: (BOOL) backToRoot;

@property id<UITableViewDataSource> dataSource;
@property id<UITableViewDelegate> delegate;

@end
