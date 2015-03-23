//
//  HighScoreViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "HighScoreController.h"
#import "HighScoreManager.h"
#import "Score.h"
#import "UINavigationController+Fade.h"
#import "UIView_Blur.h"

@interface HighScoreController () {
    HighScoreManager* hs;
}

@end

@implementation HighScoreController

+ (void)showViewReseting:(BOOL)backToRoot fromController:(UIViewController *)fromVC highlighting: (NSNumber*) highlightId {
    TableViewController* vc = [fromVC.storyboard instantiateViewControllerWithIdentifier:@"table_view"];
    vc.bgImage = [fromVC.view blur: 32];
    HighScoreController* dataAndDelegate = [[HighScoreController alloc] init];
    if (highlightId)
        dataAndDelegate.markScore = [highlightId intValue];
    vc.delegate = dataAndDelegate;
    vc.dataSource = dataAndDelegate;
    [vc setBackToRoot:backToRoot];
    [fromVC.navigationController pushFadeViewController:vc];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        hs = [HighScoreManager sharedInstance];
    }
    return self;
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
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.backgroundColor = nil;
    }
    
    Score* item = [hs scoreAt:indexPath.row];
    if (item.name)
        cell.textLabel.text = item.name;
    else
        cell.textLabel.text = @"Anônimo";
    
    if(item.key == self.markScore) {
        cell.backgroundColor = [UIColor colorWithRed:0xf9/255.0 green:0xf1/255.0 blue:0x98/255.0 alpha:0.5];
    }

    cell.detailTextLabel.text = [NSString stringWithFormat:@"R$ %d,00", item.points];
    
    switch (item.result) {
        case ResultGaveUp:
            cell.textLabel.textColor = [UIColor orangeColor];
            break;
        case ResultLost:
            cell.textLabel.textColor = [UIColor redColor];
        break;
        case ResultWon:
            cell.textLabel.textColor = [UIColor greenColor];
            break;
    }
    
    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    return cell;
}

@end
