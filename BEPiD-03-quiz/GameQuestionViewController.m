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
#import "StudentOpinion.h"

@interface GameQuestionViewController () {
    QuestionState* qs;
    long _selectedRow;
}
@property (weak, nonatomic) IBOutlet UILabel *lblQuestion;
@property (weak, nonatomic) IBOutlet UILabel *lblPrize;
@property (weak, nonatomic) IBOutlet UITableView *tvAnswers;

@end

@implementation GameQuestionViewController

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
    
    UILabel* btn= [[UILabel alloc] init];
    btn.text = @"Teste";
    [alert addSubview:btn];
    
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
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
    if (item.studentOpinion)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Aluno de %@ - %d%% de confiança", item.studentOpinion.course, (int)(item.studentOpinion.certainty * 100)];
    else
        cell.detailTextLabel.text = nil;
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    Answer* resp = [qs.question getAnswer:row];
    [self userAnswer: resp number:row];
    
    _selectedRow = indexPath.row;
    return indexPath;
}

@end
