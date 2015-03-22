//
//  QuestionsProvider.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Game.h"
#import "Question.h"
#import "Answer.h"
#import "Json.h"
#import "QuestionState.h"
#import "NSMutableArray_Shuffling.h"
#import "Score.h"

@implementation Game {
    NSMutableDictionary* _questions;
    NSMutableArray* _difficulties;
    NSMutableArray* _selectedQuestions;
    unsigned long _questionIndex;
    BOOL _usedSkip;
    BOOL _usedEliminate;
    BOOL _usingHelp;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _difficulties = [[NSMutableArray alloc] init];
        _questions = [[NSMutableDictionary alloc] init];
        _selectedQuestions = [[NSMutableArray alloc] init];
        _questionIndex = -1;
        _accumulatedPrize = 0;
        _score = [[Score alloc] init];

        [self loadQuestions];
        [self randomizeQuestions];
        [self sortByDifficulty];
        [self selectQuestions];
        [self advanceQuestion];
    }
    return self;
}

#pragma mark - Game Methods

- (unsigned long) getCurrentQuestionNumber {
    return _questionIndex + 1;
}

- (QuestionState*) getCurrentQuestion {
    if (_questionIndex >= _selectedQuestions.count)
        return nil;
    
    return _selectedQuestions[_questionIndex];
}

- (void) answer:(Answer *)userAnswer {
    QuestionState* current = self.currentQuestion;
    if ([userAnswer.question correctAnswer: userAnswer]) {
        int points = current.prize;
        if (!_usingHelp)
            current.status = CorrectAnswer;
        else
            current.status = CorrectWithHelp;
        current.answer = userAnswer;
        _accumulatedPrize += points;
        _score.points += points;
        [self advanceQuestion];
    }
    else {
        _score.result = ResultLost;
        current.status = WrongAnswer;
        _score.points /= 3;
        _status = Lost;
    }
    
    _usingHelp = NO;
}

- (SkipStatus) canSkip {
    if (_usedSkip)
        return CannotSkipAgain;
    if (_questionIndex >= _selectedQuestions.count - 1)
        return CannotSkipLastQuestion;
    return CanSkip;
}

- (void) skip {
    if ([self canSkip] != CanSkip) {
        [NSException raise:@"Skip cannot be used" format:@"Skip move not allowed"];
    }
    
    QuestionState* current = self.currentQuestion;
    current.status = Skip;
    _usedSkip = YES;
    [self advanceQuestion];
}

- (BOOL) canLeave {
    return _accumulatedPrize > 0;
}

- (NSArray*) getState {
    return _selectedQuestions;
}

- (BOOL) canEliminateAnswers {
    return !_usedEliminate;
}

- (void) eliminateAnswers: (int) quantity {
    if (![self canEliminateAnswers]) {
        [NSException raise:@"Eliminate wrong answers option already used" format:@"This options can only be used once"];
    }
    _usedEliminate = YES;
    _usingHelp = YES;
    
    QuestionState* current = self.currentQuestion;
    [current.question eliminateWrongAnswers: quantity];
    current.prize /= 2;
}

#pragma mark - Helper Methods

- (void) advanceQuestion {
    _questionIndex++;
    if (_questionIndex < _selectedQuestions.count) {
        ((QuestionState*)_selectedQuestions[_questionIndex]).status = WaitingAnswer;
        _status = InGame;
    }
    else {
        _status = Won;
        self.score.result = ResultWon;
    }
}

- (void) loadQuestions {
    for(int i = 0; ; i++) {
        NSString* fileName = [NSString stringWithFormat:@"Question%d", i];
        NSDictionary* data = [Json fromFile: fileName];
        if (!data) {
            break;
        }

        Question* question = [Question questionWithData:data];
        if (question) {
            NSNumber* difNumber = [NSNumber numberWithInt:question.difficulty];
            NSString* difKey = [NSString stringWithFormat:@"%d", question.difficulty];

            if (![_difficulties containsObject:difNumber])
                [_difficulties addObject: difNumber];

            NSMutableArray* questions = [_questions valueForKey:difKey];
            if (questions) {
                [questions addObject:question];
            }
            else {
                questions = [[NSMutableArray alloc] initWithObjects:question, nil];
                [_questions setObject:questions forKey: difKey];
            }
        }
    }
}

-(void) randomizeQuestions {
    for (NSNumber* difficulty in _difficulties) {
        NSString* difKey = [NSString stringWithFormat:@"%@", difficulty];

        NSMutableArray* questions = [_questions valueForKey:difKey];
        [questions shuffle];

        for (Question* question in questions) {
            [question randomizeAnswers];
        }
    }
}

- (void) sortByDifficulty {
    NSSortDescriptor *ascSort = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [_difficulties sortUsingDescriptors:[NSArray arrayWithObject:ascSort]];
}

- (void) selectQuestions {
    int prize = 100;
    for(int difficulty = 0; difficulty < _difficulties.count; difficulty++) {
        NSNumber* questionDifficulty = _difficulties[difficulty];
        NSString* difKey = [NSString stringWithFormat:@"%@", questionDifficulty];
        NSArray* questionsForCurrentDifficulty = [_questions valueForKey:difKey];
        
        if (!questionsForCurrentDifficulty)
            break;
        
        for (int i = 0; i < 5 && i < questionsForCurrentDifficulty.count; i++) {
            Question* question = questionsForCurrentDifficulty[i];
            QuestionState* gameQuestion = [[QuestionState alloc] initWithQuestion:question];
            gameQuestion.prize = prize;

            [_selectedQuestions addObject:gameQuestion];
        }
        
        prize *= 10;
    }
}

@end
