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

// Classe responsável por armazenar e recuperar perguntas para o jogo.
@implementation QuestionsProvider {
    NSMutableDictionary* _questions;
    NSMutableArray* _difficulties;
    int _difficultyIndex;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _difficultyIndex = 0;
        _difficulties = [[NSMutableArray alloc] init];
        _questions = [[NSMutableDictionary alloc] init];

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

        NSSortDescriptor *ascSort = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        [_difficulties sortUsingDescriptors:[NSArray arrayWithObject:ascSort]];
    }
    return self;
}

- (Question *)getQuestion {
    NSNumber* questionDifficulty = _difficulties[_difficultyIndex];
    NSString* difKey = [NSString stringWithFormat:@"%@", questionDifficulty];

    NSArray* questionsForDifficulty = [_questions valueForKey:difKey];
    if (!questionsForDifficulty || questionsForDifficulty.count <= 0)
        return nil;

    int number = arc4random() % questionsForDifficulty.count;
    return questionsForDifficulty[number];
}

- (void)increaseDifficulty {
    _difficultyIndex++;
}

@end
