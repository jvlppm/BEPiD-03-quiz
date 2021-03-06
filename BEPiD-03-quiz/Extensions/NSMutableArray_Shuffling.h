//
//  NSMutableArray_Shuffling.h
//
//  http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
//

#import <Foundation/Foundation.h>

// This category enhances NSMutableArray by providing
// methods to randomly shuffle the elements.
@interface NSMutableArray (Shuffling)

- (void)shuffle;

@end