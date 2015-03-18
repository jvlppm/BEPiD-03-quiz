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
    NSMutableArray* _questions;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _questions = [[NSMutableArray alloc] init];

        for(int i = 0; ; i++) {
            NSString* fileName = [NSString stringWithFormat:@"Question%d", i];
            NSDictionary* data = [Json fromFile: fileName];
            if (!data) {
                break;
            }

            Question* question = [Question QuestionWithData:data];
            if (question) {
                [_questions addObject:question];
            }
        }
    }
    return self;
}

@end
