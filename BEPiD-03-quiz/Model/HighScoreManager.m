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
            
            [self sortScore];
        }
    }
    return self;
}

#define MAX_SCORES 20

- (void) refreshScore {
    [self sortScore];
    if (_data.count > MAX_SCORES)
        [_data removeObjectsInRange:NSMakeRange(MAX_SCORES, _data.count - MAX_SCORES)];
}

- (void) sortScore {
    NSSortDescriptor *descSort = [NSSortDescriptor sortDescriptorWithKey:@"points" ascending:NO];
    [_data sortUsingDescriptors:[NSArray arrayWithObject:descSort]];
}

- (void)saveScore:(Score *)score {
    [_data addObject:score];
    NSData* data = [NSKeyedArchiver archivedDataWithRootObject:_data];
    [self refreshScore];
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

- (NSSet*) playerNames {
    NSMutableSet* names = [[NSMutableSet alloc] init];
    
    for (Score* sc in _data) {
        if(![names containsObject:sc.name])
            [names addObject:sc.name];
    }
    return names;
}

- (unsigned long)countScores {
    NSLog(@"HighScore: %d", _data.count);
    return _data.count;
}

- (Score *)scoreAt:(unsigned long)index {
    return _data[index];
}

@end
