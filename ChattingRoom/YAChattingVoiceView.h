//
//  YAChattingVoiceView.h
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YAChattingVoiceView;

@protocol YAChattingVoiceViewDelegate <NSObject>

- (void)didVoiceInputBtnTouchDown:(YAChattingVoiceView *)view;
- (void)didVoiceInputBtnTouchUp:(YAChattingVoiceView *)view;

@end



@interface YAChattingVoiceView : UIView
@property (nonatomic,strong) UIButton  *voiceButton;
@property (nonatomic,weak) NSObject <YAChattingVoiceViewDelegate >* delegate;
- (void)startChattingAnimation;
- (void)stopChattingAnimation;
@end
