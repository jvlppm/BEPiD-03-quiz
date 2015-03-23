//
//  ViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/17/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "StartViewController.h"
#import "Game.h"
#import "Question.h"
#import "HighScoreManager.h"
#import "Score.h"
#import "GameViewController.h"

@interface StartViewController () {
    Game* lastGame;
}

@property (weak, nonatomic) IBOutlet UIButton *btnResumeGame;

@end

@implementation StartViewController

- (void)viewWillAppear:(BOOL)animated {
    if (!lastGame || lastGame.status != InGame) {
        self.btnResumeGame.hidden = YES;
    }
    else {
        self.btnResumeGame.hidden = NO;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"new_game"])
    {
        Game* newGame = [[Game alloc] init];
        lastGame = newGame;
    }
    
    if ([[segue identifier] isEqualToString:@"high_score"])
        return;
    
    UITabBarController *vc = [segue destinationViewController];
    for (GameViewController* gameController in vc.viewControllers) {
        gameController.game = lastGame;
    }
}

@end
