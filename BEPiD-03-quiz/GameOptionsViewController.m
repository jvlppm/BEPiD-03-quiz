//
//  GameOptionsViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameOptionsViewController.h"
#import "QuestionState.h"
#import "TableViewController.h"
#import "UIView_Blur.h"
#import "UINavigationController+Fade.h"

@interface GameOptionsViewController () {
    NSString* _optionAvailableOnce;
    NSString* _optionAlreadyUsed;
    NSArray* students;
}
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;

@property (weak, nonatomic) IBOutlet UIButton *btnSkipQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblSkipQuestionDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnAskStudents;
@property (weak, nonatomic) IBOutlet UILabel *lblAskStudentsDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnLeaveGame;
@property (weak, nonatomic) IBOutlet UILabel *lblLeaveGameDescription;

@property (weak, nonatomic) IBOutlet UIButton *btnRemove2WrongAnswers;
@property (weak, nonatomic) IBOutlet UILabel *lblRemove2WrongAnswersDescription;

@end

@implementation GameOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _optionAvailableOnce = @"Esta opção só pode ser utilizada uma única vez.";
    _optionAlreadyUsed = @"Esta opção já foi utilizada.";
}

- (void)viewWillAppear:(BOOL)animated {
    students = [self.game.currentQuestion.question getStudents];
    self.lblQuestion.text = self.game.currentQuestion.question.text;
    
    [self updateSkipOption];
    [self updateHelpFromStudentsOption];
    [self updateRemove2WrongAnswersOptions];
    [self updateLeaveOption];
}

- (IBAction)finishGame:(id)sender {
    [self endGame];
}

- (void) updateHelpFromStudentsOption {
    self.btnAskStudents.enabled = [self.game canAskStudent];
    if (self.btnAskStudents.enabled)
        self.lblAskStudentsDescription.text = _optionAvailableOnce;
    else
        self.lblAskStudentsDescription.text = _optionAlreadyUsed;
}

- (IBAction)helpFromStudents:(id)sender {
    TableViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"table_view"];
    vc.bgImage = [self.view blur];
    vc.delegate = self;
    vc.dataSource = self;
    
    [self.navigationController pushFadeViewController:vc];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return students.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"studentCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"studentCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    cell.textLabel.text = students[indexPath.row];
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    [self.game askStudent:students[row]];
    [self.navigationController fadePopViewController];
    [self.tabBarController setSelectedIndex:0];
    return indexPath;
}

@end
