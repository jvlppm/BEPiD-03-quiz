//
//  QuestionsSourceDelegate.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/19/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@protocol QuestionsSourceDelegate <NSObject>

- (void) onNewQuestion: (Question*) question;
- (void) onNoMoreQuestions;

@end

