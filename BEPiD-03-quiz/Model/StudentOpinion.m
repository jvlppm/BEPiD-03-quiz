//
//  StudentOpinion.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "StudentOpinion.h"

@implementation StudentOpinion

+ (StudentOpinion *)opinionFromStudent:(NSString *)course toAnswer:(Answer *)answer withCertainty:(float)certainty {
    return [[StudentOpinion alloc] initWithAnswer:answer fromCourse:course withCertainty:certainty];
}

- (instancetype)initWithAnswer:(Answer *)answer fromCourse:(NSString *)course withCertainty:(float)certainty
{
    self = [super init];
    if (self) {
        _answer = answer;
        _certainty = certainty;
        _course = course;
    }
    return self;
}

@end
