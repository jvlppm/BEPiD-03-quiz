//
//  GameViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameViewController.h"
#import "GameOverViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void) endGame {
    GameOverViewController* itemViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"game_over"];
    itemViewController.game = self.game;
    [self showViewController:itemViewController sender:self];
}

@end
