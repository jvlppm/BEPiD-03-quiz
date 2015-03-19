//
//  ViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/17/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "ViewController.h"
#import "QuestionsProvider.h"
#import "Question.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    QuestionsProvider* questions = [[QuestionsProvider alloc] init];
    Question* question = [questions getQuestion];
    NSLog(@"%@", question.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
