//
//  Json.m
//  TrabalhoRPG
//
//  Created by João Vitor P. Moraes on 3/13/15.
//  Copyright (c) 2015 João Vitor P. Moraes. All rights reserved.
//

#import "Json.h"

@implementation Json

+ (NSDictionary*) fromFile: (NSString*) name {
    NSError* error;
    NSBundle* bundle = [NSBundle mainBundle];
    NSString* path = [bundle pathForResource:name ofType:@"json"];
    if (!path)
        return nil;
    NSString* fileContent = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    NSData* jsonData = [fileContent dataUsingEncoding:NSUTF8StringEncoding];
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
}

@end
