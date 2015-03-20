//
//  HighScoreManager.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/20/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "HighScoreManager.h"
#import "Score.h"
#import "Json.h"

@implementation HighScoreManager {
    NSMutableArray* _data;
    NSUserDefaults* userDefaults;
}

+ (id)sharedInstance {
    static HighScoreManager* instance = nil;
    static dispatch_once_t once;

    dispatch_once(&once, ^{
        instance = [[HighScoreManager alloc] init];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
        NSData* savedData = [userDefaults valueForKey:@"highscore"];
        _data = [[NSMutableArray alloc] init];

        if (savedData) {
            NSArray* array = [NSKeyedUnarchiver unarchiveObjectWithData:savedData];
            for (Score* score in array) {
                [_data addObject:score];
            }
        }
    }
    return self;
}

- (void)saveScore:(Score *)score {
    [_data addObject:score];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_data];
    [userDefaults setObject:data forKey:@"highscore"];
    [userDefaults synchronize];
}

- (int) getPositionFor: (Score*) score {
    int position = 0;
    for (Score* savedScore in _data) {
        if (savedScore.points >= score.points) {
            position++;
        }
    }
    return position + 1;
}

@end
