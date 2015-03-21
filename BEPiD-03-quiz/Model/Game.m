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

@implementation Game {
    NSMutableDictionary* _questions;
    NSMutableArray* _difficulties;
    NSMutableArray* _selectedQuestions;
    int _questionIndex;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _difficulties = [[NSMutableArray alloc] init];
        _questions = [[NSMutableDictionary alloc] init];
        _selectedQuestions = [[NSMutableArray alloc] init];

        [self loadQuestions];
        [self randomizeQuestions];
        [self sortByDifficulty];
        [self selectQuestions];
    }
    return self;
}

#pragma mark Game Methods

- (Question *)currentQuestion {
    if (_questionIndex >= _selectedQuestions.count)
        return nil;
    
    return _selectedQuestions[_questionIndex];
}

- (AnswerResponse)answer:(Answer *)userAnswer {
    if ([userAnswer.question correctAnswer: userAnswer]) {
        _questionIndex++;
        if ([self currentQuestion] == nil)
            return Won;
        return NextQuestion;
    }
    return Lost;
}

- (NSArray*) state {
    return _selectedQuestions;
}

#pragma mark Helper Methods

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
    int difficulty = 0;
    do {
        NSNumber* questionDifficulty = _difficulties[difficulty];
        if (!questionDifficulty)
            break;
        NSString* difKey = [NSString stringWithFormat:@"%@", questionDifficulty];
        NSArray* questionsForCurrentDifficulty = [_questions valueForKey:difKey];
        
        if (!questionsForCurrentDifficulty)
            break;
        
        for (int i = 0; i < 5 && i < questionsForCurrentDifficulty.count; i++) {
            Question* question = questionsForCurrentDifficulty[i];
            QuestionState* gameQuestion = [[QuestionState alloc] initWithQuestion:question];

            [_selectedQuestions addObject:gameQuestion];
        }
    } while(true);
}

@end
