//
//  YAChatMessage.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
	YAMessageStyleLeft = 0,
	YAMessageStyleRight = 1
} YAMessageStyle;


@interface YAChatMessage : NSObject


@property (nonatomic,strong) NSString *iconUrl;                         // 头像
@property (nonatomic,strong) NSString *nickName;                        // 姓名
@property (nonatomic,strong) NSString *timeStr;                         // 时间轴
@property (nonatomic,strong) NSString *content;                         // 内容
@property (nonatomic,assign) YAMessageStyle  messageStyle;              // 样式

- (id)initWithMessage:(NSString *)icon nickName:(NSString *)nickName time:(NSString *)timeStr content:(NSString *)content style:(YAMessageStyle)messageStyle;
@end
