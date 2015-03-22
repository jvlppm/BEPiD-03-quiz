//
//  GameQuestionViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameQuestionViewController.h"
#import "QuestionState.h"
#import "Answer.h"
#import "GameOverViewController.h"

@interface GameQuestionViewController () {
    QuestionState* qs;
    long _selectedRow;
}
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblPrize;
@property (weak, nonatomic) IBOutlet UITableView *tvAnswers;

@end

@implementation GameQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self reload];
}

- (void) reload {
    qs = self.game.currentQuestion;

    if (qs) {
        self.lblQuestion.text = qs.question.text;
        self.lblPrize.text = [NSString stringWithFormat:@"R$ %d,00", qs.prize];
    }
    
    _selectedRow = -1;
    [self.tvAnswers reloadData];
}

- (void) userAnswer: (Answer*) answer number: (NSInteger) number {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: answer.text
                                                   message: @"Confirma sua resposta?"
                                                  delegate: self
                                         cancelButtonTitle:@"Não"
                                         otherButtonTitles:@"Sim", nil];
    
    alert.tag = number;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        Answer* answer = [qs.question getAnswer: alertView.tag];
        [self.game answer:answer];
        qs = self.game.currentQuestion;
        NSLog(@"Game status: %lu", self.game.status);
        [self reload];
        if (self.game.status != InGame) {
            [self endGame];
        }
    }
}

- (void) endGame {
    GameOverViewController* itemViewController = (GameOverViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"game_over"];
    itemViewController.game = self.game;
    [self showViewController:itemViewController sender:self];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [qs.question countAnswers];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"answerCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"answerCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }

    Answer* item = [qs.question getAnswer: indexPath.row];
    cell.textLabel.text = item.text;
    if (item.eliminated)
        cell.textLabel.textColor = [UIColor lightGrayColor];
    else
        cell.textLabel.textColor = [UIColor blackColor];
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectedRow == indexPath.row) {
        NSInteger row = indexPath.row;
        Answer* resp = [qs.question getAnswer:row];
        [self userAnswer: resp number:row];
    }
    
    _selectedRow = indexPath.row;
    return indexPath;
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
