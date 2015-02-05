//
//  YAGroupChattingViewController.m
//  ChattingRoom
//
//  Created by wind on 5/9/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAGroupChattingViewController.h"

@interface YAGroupChattingViewController ()

@end

@implementation YAGroupChattingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    
    if (IsIOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
#if (UseInputDialog == 1)
        // 配置输入对话框
        CGRect rectInputDlg = self.chattingDialog.frame;
        rectInputDlg.origin.y -= (NavigationBarHeight + StatusBarHeight);
        [self.chattingDialog setFrame:rectInputDlg];
      
        self.originChattingDialogFrame = rectInputDlg;
        self.chattingDialog.inputVoiceType = InputVoiceType_Record;
        [self.chattingDialog setDelegate:self];
        [self.view bringSubviewToFront:self.chattingDialog];

#endif
        // 配置列表
        CGRect rectTable = self.tableview.frame;
        rectTable.size.height -= (NavigationBarHeight + StatusBarHeight) ;
        [self.tableview setFrame:rectTable];
    }
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark 

// 消息发送
- (void)didSendMessage:(NSString *)message {
    
    // DEMO HERE:
    
    if (message.length > 0) {
        YAChatMessage *myMessage = [[YAChatMessage alloc]initWithMessage:@"me.png" nickName:@"wind" time:@"12:00:05" content:message style:YAMessageStyleRight];
        YAChatMessageFrame *myMessageFrame = [[YAChatMessageFrame alloc]initWithMesssage:myMessage];
        [self.messages addObject:myMessage];
        [self.messageFrames addObject:myMessageFrame];
        
        NSIndexPath *insertIdxPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
        
        [self.tableview beginUpdates];
        [self.tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:insertIdxPath]withRowAnimation:UITableViewRowAnimationFade];
        [self.tableview endUpdates];
        
         [self.tableview scrollToRowAtIndexPath:insertIdxPath atScrollPosition:UITableViewScrollPositionBottom animated:TRUE];
    }


  }

// 开始录音
- (void)didVoiceStartRecord {
    
}

// 结束录音
- (void)didVoiceStopRecord {
    
}

// 选取图片
- (void)didPickPhoto {
    
}

@end
