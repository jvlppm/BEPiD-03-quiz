//
//  Score.h
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/20/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ResultGaveUp,
    ResultLost,
    ResultWon,
} GameResult;

@interface Score : NSObject

+ (Score*) scoreFor: (NSString*) name withPoints: (int) points;
- (instancetype) initWithName: (NSString*) name andPoints: (int) points;

- (void)encodeWithCoder: (NSCoder*) encoder;
- (id) initWithCoder: (NSCoder*) decoder;

@property int points;
@property NSString* name;
@property GameResult result;

@end
