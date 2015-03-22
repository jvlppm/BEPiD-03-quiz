//
//  HighScoreViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "HighScoreViewController.h"
#import "HighScoreManager.h"
#import "Score.h"

@interface HighScoreViewController () {
    HighScoreManager* hs;
}

@end

@implementation HighScoreViewController

- (void) backToRoot {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}


- (void) back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    hs = [HighScoreManager sharedInstance];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return hs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"progressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    Score* item = [hs scoreAt:indexPath.row];
    if (item.name)
        cell.textLabel.text = item.name;
    else
        cell.textLabel.text = @"Anônimo";

    cell.detailTextLabel.text = [NSString stringWithFormat:@"R$ %d,00", item.points];
    
    switch (item.result) {
        case ResultGaveUp:
            cell.textLabel.textColor = [UIColor yellowColor];
            break;
        case ResultLost:
            cell.textLabel.textColor = [UIColor redColor];
        break;
        case ResultWon:
            cell.textLabel.textColor = [UIColor greenColor];
            break;
    }
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    return cell;
}

@end
