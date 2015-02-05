//
//  YAPopoverChatTableViewCell.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YARichText.h"
#import "YAChatMessage.h"
#import "YAChatMessageFrame.h"




@interface YAPopoverChatTableViewCell : UITableViewCell
{
     
}

@property (nonatomic,strong)YAChatMessageFrame *messageFrame;
@property (nonatomic,strong)UIImageView  *nickIconImageView;             // 头像
@property (nonatomic,strong)UILabel      *nickNameLabel;                 // 昵称
@property (nonatomic,strong)UILabel      *timeStampLabel;                // 时间轴
@property (nonatomic,strong)UIImageView  *content;                       // 内容
@property (nonatomic,strong)YARichText   *richText;


@end
