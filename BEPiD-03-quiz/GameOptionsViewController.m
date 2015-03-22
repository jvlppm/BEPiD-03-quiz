//
//  GameOptionsViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameOptionsViewController.h"
#import "QuestionState.h"

@interface GameOptionsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@end

@implementation GameOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.lblQuestion.text = self.game.currentQuestion.question.text;
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
