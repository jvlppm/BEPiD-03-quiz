//
//  GameOverViewController.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/22/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "GameOverViewController.h"
#import "HighScoreManager.h"
#import "Score.h"
#import "HighScoreViewController.h"

@interface GameOverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblAccumulatedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblScorePositionMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UITextField *tfTypeName;
@property (weak, nonatomic) IBOutlet UITextField *tfSelectName;

@property (weak, nonatomic) IBOutlet UILabel *lblScorePositionValue;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalScoreValue;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerValue;
@property (weak, nonatomic) IBOutlet UITextField *tfPlayerName;
@property (weak, nonatomic) IBOutlet UITextField *tfSelectPlayerName;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@end

@implementation GameOverViewController {
    HighScoreManager* hs;
    NSArray* players;
    UIView* kbView;
    CGRect originalFrame;
}

- (void)viewDidLoad {
    hs = [HighScoreManager sharedInstance];
    
    originalFrame = self.view.frame;
    
    //NSArray* topPlayers = [HighScoreManager getTopPlayers];
    
    NSMutableArray* playerNames = [[NSMutableArray alloc] init];
    
    for (NSString* name in [hs playerNames]) {
        if (name != nil && ![name isEqualToString:@"Anônimo"])
            [playerNames addObject:name];
    }
    
    [playerNames addObject:@"Anônimo"];
    [playerNames addObject:@"Digitar nome"];
    
    players = playerNames;
    if (players.count > 0) {
        UIPickerView *picker = [[UIPickerView alloc] init];
        picker.dataSource = self;
        picker.delegate = self;
        kbView = self.tfSelectPlayerName.inputView;
        self.tfSelectPlayerName.inputView = picker;
    }
    
    self.tfSelectPlayerName.text =
    self.tfPlayerName.text = players[0];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateNavigation];
    [self trackKeyboard];
    [self refreshData];
}

- (void) viewWillDisappear:(BOOL)animated {
    [self stopTrackingKeyboard];
}

- (void) refreshData {
    self.lblAccumulatedValue.text = [NSString stringWithFormat:@"R$ %d,00", self.game.accumulatedPrize];
    
    int position = [hs getPositionFor:self.game.score];
    
    self.lblScorePositionValue.text = [NSString stringWithFormat:@"%d", position];
    
    if (position > MAX_SCORES) {
        self.btnSave.hidden =
        self.tfSelectName.hidden =
        self.tfTypeName.hidden =
        self.lblName.hidden =
        self.lblScorePositionMessage.hidden =
        self.lblScorePositionValue.hidden = YES;
    }
    
    self.lblFinalScoreValue.text = [NSString stringWithFormat:@"R$ %d,00", self.game.score.points];
    
    if (self.game.status != Won) {
        self.lblMessage.text = @"Que pena, você errou!";
        self.lblMessage.textColor = [UIColor redColor];
    }
    self.lblWrongAnswerValue.hidden =
    self.lblWrongAnswerMessage.hidden =
    self.game.score.points <= 0 ||
    self.game.status == Won;
}


- (void) back {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void) updateNavigation {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.leftBarButtonItem = item;
}

- (IBAction)save:(id)sender {
    self.game.score.name = self.tfPlayerName.text;
    [hs saveScore:self.game.score];
    self.btnSave.enabled = NO;
    [self showHighscore];
}

- (void) showHighscore {
    HighScoreViewController* vc = [self.storyboard instantiateViewControllerWithIdentifier:@"highscore"];
    [vc backToRoot];
    [self showViewController:vc sender:self];
}

#pragma mark - Picker View

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return players.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return  1;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return players[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (row == players.count - 1) {
        self.tfSelectPlayerName.text =
        self.tfPlayerName.text = nil;
        self.tfSelectPlayerName.hidden = YES;
        [self.tfPlayerName becomeFirstResponder];
    }
    else {
        self.tfSelectPlayerName.text =
        self.tfPlayerName.text = players[row];
        
        [self.tfSelectPlayerName resignFirstResponder];
    }
}


#pragma mark Text Field Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.tfPlayerName.text.length <= 0)
        self.tfSelectPlayerName.hidden = NO;
    return NO;
}

#pragma mark Track Keyboard

#define kOFFSET_FOR_KEYBOARD 120.0

- (void) trackKeyboard {
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void) stopTrackingKeyboard {
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)keyboardWillShow {
    [self setViewMovedUp:YES];
}

-(void)keyboardWillHide {
    [self setViewMovedUp:NO];
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = originalFrame;
    if (movedUp)
    {
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
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
