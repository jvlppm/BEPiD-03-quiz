//
//  Answer.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Question;

@interface Answer : NSObject

@property (readonly) Question* question;
@property (readonly) NSString* text;

+ (Answer*) AnswerForQuestion: (Question*) question withText: (NSString*) text;
- (instancetype) initWithQuestion: (Question*) question andText: (NSString*) text;

@end
