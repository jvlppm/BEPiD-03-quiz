//
//  HighScoreManager.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/20/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX_SCORES 20

@class Score;

@interface HighScoreManager : NSObject

@property (readonly, getter=countScores) unsigned long count;

+ (id) sharedInstance;

- (NSSet*) playerNames;

- (int) getPositionFor: (Score*) score;
- (void) saveScore: (Score*) score;

- (Score*) scoreAt: (unsigned long) index;

@end
