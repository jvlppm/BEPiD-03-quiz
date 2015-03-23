//
//  TableViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "TableViewController.h"
#import "UINavigationController+Fade.h"

@interface TableViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *ivImage;
@property (weak, nonatomic) IBOutlet UITableView *tvTable;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [self updateNavigation];
}

- (void) back {
    [self.navigationController fadePopViewController];
}

- (void) updateNavigation {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:self.navigationItem.backBarButtonItem.style target:self action:@selector(back)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}

- (void)viewWillAppear:(BOOL)animated {
    self.ivImage.image = self.bgImage;
    self.tvTable.delegate = _delegate;
    self.tvTable.dataSource = _dataSource;
}

@end
