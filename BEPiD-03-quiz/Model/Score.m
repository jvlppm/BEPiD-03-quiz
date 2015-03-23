//
//  Score.m
//  BEPiD-03-quiz
//
//  Created by João Vitor P. Moraes on 3/20/15.
//  Copyright (c) 2015 João Vitor. All rights reserved.
//

#import "Score.h"

@implementation Score

- (instancetype)init
{
    self = [super init];
    if (self) {
        _points = 0;
        _name = nil;
        _result = ResultGaveUp;
        _key = arc4random();

    }
    return self;
}

+ (Score *)scoreFor:(NSString *)name withPoints:(int)points {
    return [[Score alloc] initWithName:name andPoints: points];
}

- (instancetype)initWithName:(NSString *)name andPoints:(int)points
{
    self = [super init];
    if (self) {
        _name = name;
        _points = points;
        _key = arc4random();
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.points = [[decoder decodeObjectForKey:@"points"] intValue];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.result = [decoder decodeIntForKey:@"result"];
        self.key = [decoder decodeIntForKey:@"key"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject: [NSNumber numberWithInt:self.points] forKey:@"points"];
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeInt:self.result forKey:@"result"];
    [encoder encodeInt:self.key forKey:@"key"];
}

@end
