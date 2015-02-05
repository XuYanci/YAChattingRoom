//
//  YAChattingDialog.h
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YAFacialView.h"
#import "YAFacialEmotionView.h"
#import "YAChattingVoiceView.h"
@class YAChattingDialog;

@protocol YAChattingDialogDelegate <NSObject>

// 消息发送
- (void)didSendMessage:(NSString *)message;

// 开始录音
- (void)didVoiceStartRecord;

// 结束录音
- (void)didVoiceStopRecord;

// 选取图片
- (void)didPickPhoto;
@end

typedef enum InputType_{
    InputType_Common = 0,           // 普通输入
    InputType_Facial = 1,           // 其他输入
    InputType_Voice  = 2,           // 声音输入
    InputType_Facial_Emotion = 3,   // 表情输入
    InputType_Facial_Photo = 4      // 图片输入
}InputType;

typedef enum InputVoiceType_ {
    InputVoiceType_RealTime = 0, InputVoiceType_Record = 1
}InputVoiceType;

@interface YAChattingDialog : UIView<UITextFieldDelegate,YAFacialViewDelegate,YAFacialEmotionViewDelegate,YAChattingVoiceViewDelegate>

@property (nonatomic,strong) UIButton  *leftButton;                 // 左边按钮
@property (nonatomic,strong) UIButton  *rightButton;                // 右边按钮
@property (nonatomic,strong) UIButton  *sendButton;                 // 发送按钮
@property (nonatomic,strong) UITextField  *inputTextField;          // 输入框
@property (nonatomic,strong) UIScrollView *panel;                   // 面板
@property (nonatomic,strong) UIButton *voiceInputButton;            // 声音输入按钮

@property (nonatomic,assign) InputType  inputType;                  // 输入类型
@property (nonatomic,assign) InputVoiceType inputVoiceType;         // 语音输入类型

@property (nonatomic,weak)   NSObject <YAChattingDialogDelegate> *delegate;

- (void)resetDefaultStyle;

@end
