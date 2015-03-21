//
//  ViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/17/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"
#import "Question.h"
#import "HighScoreManager.h"
#import "Score.h"

@interface ViewController ()

@end

@implementation ViewController

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

@end
