//
//  NSMutableArray_Shuffling.m
//
//  http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
//

#import "NSMutableArray_Shuffling.h"

@implementation NSMutableArray (Shuffling)

- (void)shuffle
{
    NSUInteger count = [self count];
    for (NSUInteger i = 0; i < count; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}

@end