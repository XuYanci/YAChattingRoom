//
//  YAChatMessage.m
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAChatMessage.h"

@implementation YAChatMessage
@synthesize content,iconUrl,timeStr,nickName,messageStyle;

- (id)initWithMessage:(NSString *)_icon  nickName:(NSString *)_nickName time:(NSString *)_timeStr content:(NSString *)_content style:(YAMessageStyle)_messageStyle{

    if (self = [super init]) {
        iconUrl = _icon;
        timeStr = _timeStr;
        content = _content;
        nickName = _nickName;
        messageStyle = _messageStyle;
    }
    return self;
}
@end
