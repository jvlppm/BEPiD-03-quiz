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
    NSMutableArray* _collegeStudents;
    Answer* _correctAnswer;
}

+ (Question *)questionWithData:(NSDictionary *) data {
    return [[Question alloc] initWithData:data];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _collegeStudents = [[NSMutableArray alloc] init];
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

        for (NSDictionary* studentData in data[@"universitários"]) {
            unsigned int studentAnswerIndex = [studentData[@"resposta"] unsignedIntValue];
            StudentOpinion* opinion = [StudentOpinion opinionFromStudent: studentData[@"curso"]
                                                      toAnswer: [self getAnswer: studentAnswerIndex]
                                                      withCertainty: [studentData[@"certeza"] floatValue]];
            [_collegeStudents addObject:opinion];
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
            opinion.answer.studentOpinion = opinion;
            return opinion;
        }
    }
    return nil;
}

-(BOOL)correctAnswer:(Answer *)answer {
    return answer == _correctAnswer;
}

- (void) eliminateWrongAnswers: (int) quantity {
    NSMutableArray* couldEliminate = [[NSMutableArray alloc] init];
    for (Answer* answer in _answers) {
        if (answer != _correctAnswer) {
            [couldEliminate addObject:answer];
        }
    }
    
    [couldEliminate shuffle];
    for(int i = 0; i < couldEliminate.count; i++) {
        Answer* toEliminate = couldEliminate[i];
        toEliminate.eliminated = i < quantity;
    }
}

- (NSArray *)getStudents {
    NSMutableArray* students = [[NSMutableArray alloc] init];
    for (StudentOpinion* op in _collegeStudents) {
        [students addObject:op.course];
    }
    return students;
}

@end
