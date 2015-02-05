//
//  YAPopoverChatTableViewCellBubbleView.h
//  ChattingRoom
//
//  Created by wind on 5/7/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAPopoverChatTableViewCell.h"
#import "YARichText.h"




@class YAPopoverChatTableViewCellBubbleViewStyleFrame;
@class YAPopoverChatTableViewCellBubbleView;



 
@interface YAPopoverChatTableViewCellBubbleView : UIView


@property (nonatomic,assign)YAMessageStyle  style;
@property (nonatomic,assign)YAChatMessage   *message;

@property (nonatomic,strong)UIImageView  *nickIconImageView;         // 头像
@property (nonatomic,strong)UILabel  *nickNameLabel;                 // 昵称
@property (nonatomic,strong)UILabel  *timeStampLabel;                // 时间轴
@property (nonatomic,strong)UIView   *content;                       // 内容
@property (nonatomic,assign)CGFloat  bubbleViewHeight;               // 内容高度
@end


