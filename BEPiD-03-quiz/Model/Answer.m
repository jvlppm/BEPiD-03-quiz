//
//  Answer.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Answer.h"

@implementation Answer

+ (Answer *)AnswerForQuestion:(Question *)question withText:(NSString *)text {
    return [[Answer alloc] initWithQuestion:question andText:text];
}

- (instancetype)initWithQuestion:(Question *)question andText:(NSString *)text
{
    self = [super init];
    if (self) {
        _question = question;
        _text = text;
    }
    return self;
}

@end
