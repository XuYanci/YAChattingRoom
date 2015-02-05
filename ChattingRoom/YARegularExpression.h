//
//  YARegularExpression.h
//  ChattingRoom
//
//  Created by wind on 5/6/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YARegularExpression : NSObject


+ (NSArray *)itemIndexesWithPattern:(NSString *)pattern inString:(NSString *)findingString;
+ (NSArray *)itemStringsWithPattern:(NSString *)pattern inString:(NSString *) findingString;

@end
