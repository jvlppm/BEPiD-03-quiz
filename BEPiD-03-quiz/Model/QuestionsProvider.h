//
//  QuestionsProvider.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface QuestionsProvider : NSObject

- (instancetype) init;
- (Question*) getQuestion;

- (void) increaseDifficulty;

@end
