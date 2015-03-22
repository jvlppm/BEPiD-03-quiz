//
//  GameOptionsViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameOptionsViewController.h"
#import "QuestionState.h"

@interface GameOptionsViewController () {
    NSString* _optionAvailableOnce;
    NSString* _optionAlreadyUsed;
}
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@property (weak, nonatomic) IBOutlet UIButton *btnSkipQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblSkipQuestionDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnLeaveGame;
@property (weak, nonatomic) IBOutlet UILabel *lblLeaveGameDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove2WrongAnswers;
@property (weak, nonatomic) IBOutlet UILabel *lblRemove2WrongAnswersDescription;

@end

@implementation GameOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _optionAvailableOnce = @"Esta opção só pode ser utilizada uma única vez.";
    _optionAlreadyUsed = @"Esta opção já foi utilizada.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.lblQuestion.text = self.game.currentQuestion.question.text;
    
    [self updateSkipOption];
    [self updateRemove2WrongAnswersOptions];
    [self updateLeaveOption];
}

- (void) updateSkipOption {
    switch ([self.game canSkip]) {
        case CanSkip:
            self.btnSkipQuestion.enabled = YES;
            self.lblSkipQuestionDescription.text = _optionAvailableOnce;
            break;
        case CannotSkipAgain:
            self.btnSkipQuestion.enabled = NO;
            self.lblSkipQuestionDescription.text = _optionAlreadyUsed;
            break;
        case CannotSkipLastQuestion:
            self.btnSkipQuestion.enabled = NO;
            self.lblSkipQuestionDescription.text = @"A última questão não pode ser pulada.";
            break;
    }
}

- (IBAction)skipQuestion:(id)sender {
    [self.game skip];
    [self updateSkipOption];
    [self.tabBarController setSelectedIndex:0];
}

- (void) updateRemove2WrongAnswersOptions {
    self.btnRemove2WrongAnswers.enabled = [self.game canEliminateAnswers];
    if (self.btnRemove2WrongAnswers.enabled)
        self.lblRemove2WrongAnswersDescription.text = _optionAvailableOnce;
    else
        self.lblRemove2WrongAnswersDescription.text = _optionAlreadyUsed;
}

- (IBAction)eliminateWrongAnswers:(id)sender {
    [self.game eliminateAnswers:2];
    [self updateRemove2WrongAnswersOptions];
    [self.tabBarController setSelectedIndex:0];
}

- (void) updateLeaveOption {
    if ([self.game canLeave]) {
        self.lblLeaveGameDescription.text = [NSString stringWithFormat:@"Encerra jogo com R$ %d,00", self.game.accumulatedPrize];
    }
    
    self.btnLeaveGame.enabled = [self.game canLeave];
    self.btnLeaveGame.hidden =
    self.lblLeaveGameDescription.hidden = ![self.game canLeave];
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
