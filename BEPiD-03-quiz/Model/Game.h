//
//  QuestionsProvider.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;
@class QuestionState;
@class Answer;

typedef enum : NSUInteger {
    InGame,
    Lost,
    Won,
} GameStatus;

typedef enum : NSUInteger {
    CanSkip,
    CannotSkipAgain,
    CannotSkipLastQuestion,
} SkipStatus;

@interface Game : NSObject

@property (readonly, getter=getCurrentQuestion) QuestionState* currentQuestion;
@property (readonly, getter=getState) NSArray* state;
@property (readonly) int accumulatedPrize;
@property (readonly) GameStatus status;

- (instancetype) init;
- (void) answer: (Answer*) answer;

- (SkipStatus) canSkip;
- (void) skip;

- (BOOL) canEliminateAnswers;
- (void) eliminateAnswers: (int) quantity;

- (BOOL) canLeave;

@end
