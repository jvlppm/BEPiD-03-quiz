//
//  StudentOpinion.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Answer;

@interface StudentOpinion : NSObject

@property NSString* course;
@property float certainty;
@property Answer* answer;

+ (StudentOpinion*) opinionFromStudent: (NSString*) course toAnswer: (Answer*) answer withCertainty: (float) certainty;

- (instancetype) initWithAnswer: (Answer*) answer fromCourse: (NSString*) course withCertainty: (float) certainty;

@end
