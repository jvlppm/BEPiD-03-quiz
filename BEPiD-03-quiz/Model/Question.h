//
//  Question.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;
@class StudentOpinion;

@interface Question : NSObject

@property NSString* text;
@property Answer* correctAnswer;
@property int difficulty;

+ (Question*) questionWithData: (NSDictionary*) data;
- (instancetype) initWithData: (NSDictionary*) data;

- (unsigned long) countAnswers;
- (Answer*) getAnswer: (unsigned long) answer;
- (void) randomizeAnswers;

- (StudentOpinion*) askCollegeStudent: (NSString*) curso;

@end
