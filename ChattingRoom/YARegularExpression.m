//
//  YARegularExpression.m
//  ChattingRoom
//
//  Created by wind on 5/6/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YARegularExpression.h"

@implementation YARegularExpression


+ (NSArray *)itemIndexesWithPattern:(NSString *)pattern inString:(NSString *)findingString
{
    NSAssert(pattern != nil, @"%s: pattern 不可以为 nil", __PRETTY_FUNCTION__);
    NSAssert(findingString != nil, @"%s: findingString 不可以为 nil", __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:
                                   pattern options:NSRegularExpressionCaseInsensitive
                                                                         error:&error];
    
   
    NSArray *result = [regExp matchesInString:findingString options:
                       NSMatchingReportCompletion range:
                       NSMakeRange(0, [findingString length])];
    
    if (error) {
        NSLog(@"ERROR: %@", result);
        return nil;
    }
    
    NSUInteger count = [result count];
    
    if (0 == count) {
        return [NSArray array];
    }
    
 
    NSMutableArray *ranges = [[NSMutableArray alloc] initWithCapacity:count];
    for(NSInteger i = 0; i < count; i++)
    {
        @autoreleasepool {
            NSRange aRange = [[result objectAtIndex:i] range];
            [ranges addObject:[NSValue valueWithRange:aRange]];
        }
    }
    return ranges;

}

+ (NSArray *)itemStringsWithPattern:(NSString *)pattern inString:(NSString *) findingString {
    
    NSAssert(pattern != nil, @"%s: pattern 不可以为 nil", __PRETTY_FUNCTION__);
    NSAssert(findingString != nil, @"%s: findingString 不可以为 nil", __PRETTY_FUNCTION__);
    

    NSError *error = nil;
    NSRegularExpression *regExp = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                     options:NSRegularExpressionCaseInsensitive error:&error];
  
    NSMutableArray *results = [[NSMutableArray alloc] init];
    NSRange searchRange = NSMakeRange(0, [findingString length]);
    [regExp enumerateMatchesInString:findingString options:0 range:searchRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        NSRange groupRange =  [result rangeAtIndex:0];
        NSString *match = [findingString substringWithRange:groupRange];
        [results addObject:match];
    }];
    return results;
    
}

@end
