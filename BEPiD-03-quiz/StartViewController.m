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

@interface StartViewController ()

@end

@implementation StartViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"new_game"])
    {
        Game* newGame = [[Game alloc] init];
        
        UITabBarController *vc = [segue destinationViewController];
        for (GameViewController* gameController in vc.viewControllers) {
            gameController.game = newGame;
        }
    }
}

@end
