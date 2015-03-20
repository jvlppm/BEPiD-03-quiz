//
//  QuestionsSource.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/19/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class QuestionsSourceDelegate;

@protocol QuestionsSource<NSObject>

- (void) startLoadingQuestions: QuestionsSourceDelegate;

@end
