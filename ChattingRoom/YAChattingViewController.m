//
//  YAGroupChattingViewController.m
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAChattingViewController.h"
#import "YATouchTableView.h"
#import "YAPopoverChatTableViewCell.h"

@interface YAChattingViewController ()

@end

@implementation YAChattingViewController
@synthesize tableview,messages,messageFrames,chattingDialog;
@synthesize originChattingDialogFrame;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)configUI {
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
#if (UseInputDialog == 1)
    // Config input dialog
    CGFloat const dialogHeight = 60;
    CGFloat dialogY = self.view.frame.size.height - dialogHeight;
    
    chattingDialog = [[YAChattingDialog alloc]initWithFrame:CGRectMake(0, dialogY , CGRectGetWidth(self.view.frame), dialogHeight)];
    [self.view addSubview:chattingDialog];
    
    originChattingDialogFrame = chattingDialog.frame;
    
    // Config tableview
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetMinY(chattingDialog.frame))];

#else
    self.tableview = [[UITableView alloc]initWithFrame:self.view.frame];
#endif


    [self.tableview setDelegate:self];
    [self.tableview setDataSource:self];
    [self.view addSubview:self.tableview];
    [self.tableview reloadData];

    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    /* 点击屏幕隐藏键盘手势 */
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableview addGestureRecognizer:gestureRecognizer];
}

- (void)configEnv {
   
    // DEMO:
    messages = [[NSMutableArray alloc]init];
    messageFrames = [[NSMutableArray alloc]init];
    
    YAChatMessage *messageLeft = [[YAChatMessage alloc]initWithMessage:@"me.png" nickName:@"yun" time:@"12:00:05" content:@"Hello,Welcome to Yunva" style:YAMessageStyleLeft];
    YAChatMessage *messageRight = [[YAChatMessage alloc]initWithMessage:@"me.png"
                                                               nickName:@"wind" time:@"12:00:05"
                                                                content:@"Hello,Welcome to Yunva"
                                                                  style:YAMessageStyleRight];
    
    for (int i = 0; i < 3; i++) {
        [messages addObject:messageLeft];
        [messages addObject:messageRight];
    }
    
    for (NSUInteger i = 0; i < messages.count; i++) {
        YAChatMessageFrame *frame = [[YAChatMessageFrame alloc]init];
        [frame setChatMessage:[messages objectAtIndex:i]];
        [messageFrames addObject:frame];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    [self configEnv];
    [self configUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    
}

#pragma mark keyboard

- (void)keyboardWillShow:(NSNotification *)notification {
 
    CGSize keyboardSize_end = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    

    // Restore frame
    CGRect rect = originChattingDialogFrame;

    // Caculate bottom height , from screen bottom to self.bottom
    float bottomHeight =  [[UIScreen mainScreen]bounds].size.height -  (self.view.frame.origin.y + originChattingDialogFrame.origin.y + originChattingDialogFrame.size.height);

    if (keyboardSize_end.height - bottomHeight > 0) {
        float viewYOffset =  keyboardSize_end.height - bottomHeight;
        rect.origin.y -= viewYOffset;
    
        [chattingDialog setFrame:rect];
        [self.view bringSubviewToFront:chattingDialog];
    }

    // 键盘弹出，列表上移
    UIEdgeInsets contentInsets;
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize_end.height), 0.0);
    } else {
        contentInsets = UIEdgeInsetsMake(0.0, 0.0, (keyboardSize_end.width), 0.0);
    }
    
    self.tableview.contentInset = contentInsets;
    self.tableview.scrollIndicatorInsets = contentInsets;
    [self.tableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:messageFrames.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    
    [chattingDialog setFrame:originChattingDialogFrame];
    
    // 恢复列表
    self.tableview.contentInset = UIEdgeInsetsZero;
    self.tableview.scrollIndicatorInsets = UIEdgeInsetsZero;
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

- (void)hideKeyboard
{
    [chattingDialog endEditing:true];
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [chattingDialog endEditing:true];
}


#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YAChatMessageFrame *frame = [messageFrames objectAtIndex:[indexPath row]];
    return frame.height + 20;
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [messageFrames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"PopOverCell";
    
    YAPopoverChatTableViewCell *cell = (YAPopoverChatTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[YAPopoverChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    YAChatMessageFrame *frame = [messageFrames objectAtIndex:[indexPath row]];
    cell.messageFrame = frame;
 
    return cell;
}


@end
