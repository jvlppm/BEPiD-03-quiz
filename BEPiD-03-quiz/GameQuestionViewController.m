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

@interface GameQuestionViewController () {
    QuestionState* qs;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    qs = self.game.currentQuestion;
    
    self.lblQuestion.text = qs.question.text;
    self.lblPrize.text = [NSString stringWithFormat:@"R$ %d,00", qs.prize];
    
    [self.tvAnswers reloadData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
