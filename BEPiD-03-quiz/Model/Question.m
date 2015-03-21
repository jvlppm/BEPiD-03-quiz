//
//  Question.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/18/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Question.h"
#import "Answer.h"
#import "StudentOpinion.h"
#import "NSMutableArray_Shuffling.h"

@implementation Question {
    NSMutableArray* _answers;
    NSMutableDictionary* _collegeStudents;
    Answer* _correctAnswer;
}

+ (Question *)questionWithData:(NSDictionary *) data {
    return [[Question alloc] initWithData:data];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _collegeStudents = [[NSMutableDictionary alloc] init];
        _answers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype) initWithData: (NSDictionary*) data {
    self = [self init];
    if (self) {
        _text = data[@"texto"];
        for (NSString* resposta in data[@"respostas"]) {
            [self addAnswer:[Answer AnswerForQuestion:self withText:resposta]];
        }
        int correctAnswerIndex = [data[@"resposta_correta"] intValue];
        _correctAnswer = _answers[correctAnswerIndex];

        _difficulty = [data[@"dificuldade"] intValue];

        for (NSDictionary* studentData in data[@"universitarios"]) {
            unsigned int studentAnswerIndex = [studentData[@"resposta"] unsignedIntValue];
            StudentOpinion* opinion = [StudentOpinion opinionFromStudent: studentData[@"curso"]
                                                      toAnswer: [self getAnswer: studentAnswerIndex]
                                                      withCertainty: [studentData[@"certeza"] floatValue]];
            [_collegeStudents setObject:opinion forKey:opinion.course];
        }
    }
    return self;
}

- (void)addAnswer:(Answer *)answer {
    [_answers addObject:answer];
}

- (Answer*) getAnswer: (unsigned long) number {
    return _answers[number];
}

- (unsigned long)countAnswers {
    return _answers.count;
}

- (void) randomizeAnswers {
    [_answers shuffle];
}

- (StudentOpinion *)askCollegeStudent:(NSString *)course {
    for (StudentOpinion* opinion in _collegeStudents) {
        if ([opinion.course isEqualToString: course]) {
            return opinion;
        }
    }
    return nil;
}

-(BOOL)correctAnswer:(Answer *)answer {
    return answer == _correctAnswer;
}

@end
