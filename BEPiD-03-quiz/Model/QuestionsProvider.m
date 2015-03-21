//
//  QuestionsProvider.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "QuestionsProvider.h"
#import "Question.h"
#import "Json.h"
#import "NSMutableArray_Shuffling.h"

// Classe responsável por armazenar e recuperar perguntas para o jogo.
@implementation QuestionsProvider {
    NSMutableDictionary* _questions;
    NSMutableArray* _difficulties;
    int _difficultyIndex;
    int _questionIndex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _difficultyIndex = 0;
        _difficulties = [[NSMutableArray alloc] init];
        _questions = [[NSMutableDictionary alloc] init];

        [self loadQuestions];
        [self randomizeQuestions];
        [self sortByDifficulty];
    }
    return self;
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

- (Question *)getQuestion {
    NSNumber* questionDifficulty = _difficulties[_difficultyIndex];
    NSString* difKey = [NSString stringWithFormat:@"%@", questionDifficulty];

    NSArray* questionsForCurrentDifficulty = [_questions valueForKey:difKey];
    if (!questionsForCurrentDifficulty || questionsForCurrentDifficulty.count <= 0)
        return nil;

    Question* question = questionsForCurrentDifficulty[_questionIndex];
    _questionIndex = (_questionIndex + 1) % questionsForCurrentDifficulty.count;
    return question;
}

- (void)increaseDifficulty {
    _difficultyIndex++;
    _questionIndex = 0;
}

@end
