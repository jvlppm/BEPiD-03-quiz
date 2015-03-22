//
//  GameProgressViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameProgressViewController.h"
#import "QuestionState.h"
#import "Answer.h"

@interface GameProgressViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblAccumulatedPrize;

@end

@implementation GameProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    self.lblAccumulatedPrize.text = [NSString stringWithFormat:@"R$ %d,00", self.game.accumulatedPrize];
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    for(int i = 0; i < self.game.state.count; i++) {
        QuestionState* q = [self.game.state objectAtIndex:i];
        if (q.status == Waiting) {
            return i;
        }
    }
    return self.game.state.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"progressCell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"progressCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    QuestionState* item = (QuestionState*)[self.game.state objectAtIndex:indexPath.row];
    cell.textLabel.text = item.question.text;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"R$ %d,00", item.prize];
    
    switch (item.status) {
        case CorrectAnswer:
        case CorrectWithHelp:
            cell.textLabel.textColor = [UIColor greenColor];
            break;
        case WaitingAnswer:
            cell.textLabel.textColor = [UIColor grayColor];
            break;
        case Waiting:
            cell.textLabel.textColor = [UIColor lightGrayColor];
            break;
        default:
            cell.textLabel.textColor = [UIColor blackColor];
            cell.imageView.image = nil;
            break;
    }
    
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    
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
