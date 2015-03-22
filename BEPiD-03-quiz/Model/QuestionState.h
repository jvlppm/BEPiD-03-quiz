//
//  QuestionState.h
//  BEPiD-03-quiz
//
//  Created by João Vitor on 3/21/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Question.h"

typedef enum : NSUInteger {
    Waiting,
    WaitingAnswer,
    CorrectAnswer,
    Skip,
    CorrectWithHelp
} QuestionStatus;

@interface QuestionState : NSObject

@property QuestionStatus status;
@property Question* question;
@property int prize;
@property Answer* answer;

- (instancetype) initWithQuestion: (Question*) question;

@end
