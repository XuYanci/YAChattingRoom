//
//  YAGroupChattingViewController.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YATouchTableView.h"
#import "YAPopoverChatTableViewCell.h"



@interface YAGroupChattingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UITableView *tableview;
 
@end
