//
//  YAChatMessageFrame.h
//  ChattingRoom
//
//  Created by wind on 5/8/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <Foundation/Foundation.h>


@class YAChatMessage;
@interface YAChatMessageFrame : NSObject
@property (nonatomic,strong) YAChatMessage *chatMessage;

@property (nonatomic,assign)CGRect rectNickIcon;
@property (nonatomic,assign)CGRect rectNickName;
@property (nonatomic,assign)CGRect rectTimeStamp;
@property (nonatomic,assign)CGRect rectContent;
@property (nonatomic,assign)CGRect rectContentRichText;
@property (nonatomic,assign)CGFloat height;

- (id)initWithMesssage:(YAChatMessage *)message;

@end
