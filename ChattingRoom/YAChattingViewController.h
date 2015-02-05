//
//  YAGroupChattingViewController.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAChattingDialog.h"
#import "chatroom_public.h"
#import "YAChatMessage.h"
#import "YAChatMessageFrame.h"

@interface YAChattingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableview;                 /* 列表 */
@property (nonatomic,strong) YAChattingDialog *chattingDialog;       /* 输入框 */
@property (nonatomic,strong) NSMutableArray *messages;               /* 消息 */
@property (nonatomic,strong) NSMutableArray *messageFrames;          /* 消息样式*/
@property (nonatomic,assign) CGRect originChattingDialogFrame;      /* 原输入框框架 */
@end
