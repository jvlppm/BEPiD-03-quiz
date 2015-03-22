//
//  GameOverViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameOverViewController.h"
#import "HighScoreManager.h"
#import "Score.h"

@interface GameOverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblAccumulatedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblScorePositionValue;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalScoreValue;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerValue;

@end

@implementation GameOverViewController {
    HighScoreManager* hs;
}

- (void)viewDidLoad {
    hs = [HighScoreManager sharedInstance];
}

- (void)viewWillAppear:(BOOL)animated {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
    
    self.lblAccumulatedValue.text = [NSString stringWithFormat:@"R$ %d,00", self.game.accumulatedPrize];
    
    self.lblScorePositionValue.text = [NSString stringWithFormat:@"%d", [hs getPositionFor:self.game.score]];
    
    self.lblFinalScoreValue.text = [NSString stringWithFormat:@"R$ %d,00", self.game.score.points];
    
    if (self.game.status != Won) {
        self.lblMessage.text = @"Que pena, você errou!";
        self.lblMessage.textColor = [UIColor redColor];
    }
    self.lblWrongAnswerValue.hidden =
    self.lblWrongAnswerMessage.hidden =
    self.game.score.points <= 0 ||
    self.game.status == Won;
}


- (void) back {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
