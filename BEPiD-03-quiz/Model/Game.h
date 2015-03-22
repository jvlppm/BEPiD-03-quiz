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
    NextQuestion,
    Lost,
    Won,
} AnswerResponse;

@interface Game : NSObject

@property (readonly, getter=getCurrentQuestion) QuestionState* currentQuestion;
@property (readonly, getter=getState) NSArray* state;
@property (readonly) int accumulatedPrize;

- (instancetype) init;
- (AnswerResponse) answer: (Answer*) answer;

@end
