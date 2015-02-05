//
//  YATouchTableView.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TouchTableViewDelegate <NSObject>

@optional

- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView hitTest:(CGPoint)point withEvent:(UIEvent *)event;
@end

@interface YATouchTableView : UITableView
@property (nonatomic,assign) id<TouchTableViewDelegate> touchDelegate;
@end
