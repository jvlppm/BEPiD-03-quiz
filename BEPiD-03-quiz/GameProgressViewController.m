//
//  GameProgressViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameProgressViewController.h"

@interface GameProgressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAccumulatedPrize;

@end

@implementation GameProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.lblAccumulatedPrize.text = [NSString stringWithFormat:@"R$ %d,00", self.game.accumulatedPrize];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
