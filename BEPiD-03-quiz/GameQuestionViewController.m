//
//  GameQuestionViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameQuestionViewController.h"
#import "QuestionState.h"

@interface GameQuestionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblPrize;

@end

@implementation GameQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    QuestionState* qs = self.game.currentQuestion;
    
    self.lblQuestion.text = qs.question.text;
    self.lblPrize.text = [NSString stringWithFormat:@"R$ %d,00", qs.prize];
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
