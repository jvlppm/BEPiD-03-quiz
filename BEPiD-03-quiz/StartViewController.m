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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    /*
    Score* testScore = [Score scoreFor:@"Joao Vitor" withPoints:100];

    HighScoreManager* hs = [HighScoreManager sharedInstance];
    int pos = [hs getPositionFor:testScore];
    NSLog(@"Position: %d", pos);

    [hs saveScore:testScore];

    QuestionsProvider* questions = [[QuestionsProvider alloc] init];
    Question* question = [questions getQuestion];
    NSLog(@"Question: %@", question.text);
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
