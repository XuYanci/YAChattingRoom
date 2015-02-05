//
//  NSString+YAExtension.m
//  ChattingRoom
//
//  Created by wind on 5/6/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "NSString+YAExtension.h"

@implementation NSString (YAExtension)

- (NSString *)replaceCharactersAtIndexes:(NSArray *)indexes withString:(NSString *)aString
{
    NSAssert(indexes != nil, @"%s: indexes 不可以为nil", __PRETTY_FUNCTION__);
    NSAssert(aString != nil, @"%s: aString 不可以为nil", __PRETTY_FUNCTION__);
    
    NSUInteger offset = 0;
    NSMutableString *raw = [self mutableCopy];
    
    NSInteger prevLength = 0;
    for(NSInteger i = 0; i < [indexes count]; i++)
    {
        @autoreleasepool {
            NSRange range = [[indexes objectAtIndex:i] rangeValue];
            prevLength = range.length;
            
            range.location -= offset;
            [raw replaceCharactersInRange:range withString:aString];
            offset = offset + prevLength - [aString length];
        }
    }
    
    return raw;
}

 
@end
