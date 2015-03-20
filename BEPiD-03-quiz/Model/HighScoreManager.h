//
//  HighScoreManager.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/20/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Score;

@interface HighScoreManager : NSObject

+ (id) sharedInstance;

- (int) getPositionFor: (Score*) score;
- (void) saveScore: (Score*) score;

@end
