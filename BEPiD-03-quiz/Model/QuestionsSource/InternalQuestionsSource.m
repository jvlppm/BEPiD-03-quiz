//
//  InternalQuestionsSource.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/19/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Question.h"
#import "QuestionsSourceDelegate.h"
#import "InternalQuestionsSource.h"
#import "Json.h"

@implementation InternalQuestionsSource {
    BOOL _canRead;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _canRead = YES;
    }
    return self;
}

- (void)startLoadingQuestions:(NSObject<QuestionsSourceDelegate>*) delegate {
    @synchronized(self) {
        if (!_canRead)
            [NSException raise:@"Source already used" format:@"QuestionsSource cannot be used twice"];
        _canRead = NO;
    }

    for(int i = 0; ; i++) {
        NSString* fileName = [NSString stringWithFormat:@"Question%d", i];
        NSDictionary* data = [Json fromFile: fileName];
        if (!data) {
            break;
        }

        Question* question = [Question questionWithData: data];
        [delegate onNewQuestion: question fromSource: self];
    }
}

@end
