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

@interface GameOverViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblAccumulatedValue;
@property (weak, nonatomic) IBOutlet UILabel *lblScorePositionValue;
@property (weak, nonatomic) IBOutlet UILabel *lblFinalScoreValue;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblWrongAnswerValue;
@property (weak, nonatomic) IBOutlet UITextField *tfPlayerName;
@property (weak, nonatomic) IBOutlet UITextField *tfSelectPlayerName;

@end

@implementation GameOverViewController {
    HighScoreManager* hs;
    NSArray* players;
    UIView* kbView;
}

- (void)viewDidLoad {
    hs = [HighScoreManager sharedInstance];
    
    //NSArray* topPlayers = [HighScoreManager getTopPlayers];
    
    char* login = getlogin();
    NSString *nsLogin = [NSString stringWithUTF8String:login];
    
    NSMutableArray* playerNames = [[NSMutableArray alloc] init];
    [playerNames addObject:nsLogin];
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
    
    self.lblScorePositionValue.text = [NSString stringWithFormat:@"%d", [hs getPositionFor:self.game.score]];
    
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

#pragma mark Track Keyboard

#define kOFFSET_FOR_KEYBOARD 180.0

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
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    if ([sender isEqual:self.tfPlayerName] || [sender isEqual:self.tfSelectPlayerName])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp:YES];
        }
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
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
