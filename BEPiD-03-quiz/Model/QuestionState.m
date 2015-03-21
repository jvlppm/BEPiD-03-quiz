//
//  QuestionState.m
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "QuestionState.h"

@implementation QuestionState

- (instancetype)initWithQuestion:(Question *)question
{
    self = [super init];
    if (self) {
        _question = question;
        _status = Waiting;
    }
    return self;
}

@end
