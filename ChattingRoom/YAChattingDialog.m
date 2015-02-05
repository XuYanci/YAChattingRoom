//
//  YAChattingDialog.m
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAChattingDialog.h"
#import "UIButton+Bootstrap.h"


#define FACIAL_EMOTION_PANEL_HEIGHT     150          // 表情面板尺寸
#define FACIAL_PANEL_HEIGHT             100          // 悬着面板尺寸
#define VOICE_PANEL_HEIGHT              150          // 语音面板尺寸
#define BTN_RECT_WH                     34           // 按钮尺寸
#define ANIMATION                       FALSE        // 动画效果

@implementation YAChattingDialog {
    CGRect originViewFrame;
    YAFacialView *facialView;               // 选择面板
    YAChattingVoiceView *chattingVoiceView;
    NSMutableArray *facialEmotionViews;     // 表情面板
    NSMutableArray *emotionsArray;          // 表情图像数组
    NSMutableArray *emotionsKeyArray;       // 表情图像值
    BOOL    firstSetUp;
}


@synthesize leftButton,rightButton,sendButton,inputTextField,panel,voiceInputButton,inputType,inputVoiceType,delegate;

- (void)configFacialEmotions {
    
    emotionsArray = [[NSMutableArray alloc]init];
    emotionsKeyArray = [[NSMutableArray alloc]init];
    
    
    __strong NSArray *emotionArray_01 = [NSArray arrayWithObjects:@"f_1.png",@"f_2.png",@"f_3.png",
                                                             @"f_4.png",@"f_5.png",@"f_6.png",
                                                             @"f_7.png", @"f_8.png",@"f_9.png",
                                                             @"f_10.png",@"f_11.png",@"f_12.png",
                                                             @"f_13.png",@"f_14.png",@"f_15.png",
                                                             @"f_16.png",@"f_17.png",@"f_18.png",
                                                             @"f_19.png",@"f_20.png",@"",
                                                         nil];
    
    __strong NSArray *emotionArray_02 = [NSArray arrayWithObjects:@"f_21.png",@"f_22.png",
                                         @"f_23.png",@"f_24.png",@"f_25.png",
                                         @"f_26.png", @"f_27.png",@"f_28.png",
                                         @"f_29.png",@"f_30.png",@"f_31.png",
                                         @"f_32.png",@"f_33.png",@"f_34.png",
                                         @"f_35.png",@"f_36.png",@"f_37.png",
                                         @"f_38.png",@"f_39.png",@"f_40.png",@"",
                                         nil];
    
    
    __strong NSArray *emotionKeyArray_01 = [NSArray arrayWithObjects:@"[傻笑]",@"[惊愕]",@"[生气]",
                                         @"[狡诈]",@"[受伤]",@"[闭嘴]",
                                         @"[愤怒]", @"[开心]",@"[龇牙]",
                                         @"[吐舌]",@"[酷]",@"[暴怒]",
                                         @"[撇嘴]",@"[地雷]",@"[思考]",
                                         @"[大笑]",@"[哭]",@"[ET]",
                                         @"[色色]",@"[伤心]",@"[del]",
                                         nil];
    
    __strong NSArray *emotionKeyArray_02 = [NSArray arrayWithObjects:@"[中枪]",@"[玫瑰]",
                                         @"[枪]",@"[火]",@"[咖啡]",
                                         @"[亲亲]", @"[太阳]",@"[蛋糕]",
                                         @"[刀]",@"[屎]",@"[勾引]",
                                         @"[拳头]",@"[赞]",@"[弱]",
                                         @"[抱拳]",@"[握手]",@"[OK]",
                                         @"[胜利]",@"[心碎]",@"[心]",@"[del]",
                                         nil];
    
    
    
    [emotionsArray addObject:emotionArray_01];
    [emotionsArray addObject:emotionArray_02];
    [emotionsKeyArray addObject:emotionKeyArray_01];
    [emotionsKeyArray addObject:emotionKeyArray_02];
}

- (void)configUserInterface {
    
    leftButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    voiceInputButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [voiceInputButton setFrame:CGRectZero];
    [voiceInputButton setTitle:@"按住说话" forState:UIControlStateNormal];
    [voiceInputButton addTarget:self action:@selector(voiceInputTouchDown:) forControlEvents:UIControlEventTouchDown];
    [voiceInputButton addTarget:self action:@selector(voiceInputTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    

    rightButton = [[UIButton alloc]initWithFrame:CGRectZero];
    [rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    inputTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    inputTextField.textAlignment = NSTextAlignmentLeft;
    [inputTextField setDelegate:self];
    [inputTextField setBorderStyle:UITextBorderStyleRoundedRect];

    // Config subview frame
    CGRect rect = self.frame;
   
    // 10 - (LEFT_BTN) - 10 - (INPUT <Caculate> ) - 10 - (RIGHT_BTN) - 20 - (SEND_BTN) - 10
    
    [self.leftButton setFrame:CGRectMake(10, 10, BTN_RECT_WH, BTN_RECT_WH)];
    [self.rightButton setFrame:CGRectMake(rect.size.width - BTN_RECT_WH - 10, 10, BTN_RECT_WH, BTN_RECT_WH)];
    [self.voiceInputButton setFrame:CGRectZero];
    
    
    CGRect rectInputTextField = CGRectZero;
    
    rectInputTextField.origin.x = 10 + BTN_RECT_WH + 10;
    rectInputTextField.origin.y = 10;
    
    rectInputTextField.size.width = CGRectGetMinX(self.rightButton.frame) - CGRectGetMaxX(self.leftButton.frame) - 20;
    rectInputTextField.size.height = BTN_RECT_WH;
    
    [self.inputTextField setReturnKeyType:UIReturnKeySend];
    [self.inputTextField setFrame:rectInputTextField];
    
    [self.inputTextField addTarget:self action:@selector(handleTapInTextField) forControlEvents:UIControlEventTouchDown];
    
    [self.voiceInputButton setFrame:rectInputTextField];
     self.voiceInputButton.layer.masksToBounds = TRUE;
    self.voiceInputButton.layer.cornerRadius = 7;
    
 
    rgb_value_t begin,end;
    
    begin.R = 232 / 255.0;
    begin.G = 237 / 255.0;
    begin.B = 241 / 255.0;
    
    end.R = 167 / 255.0;
    end.G = 171 / 255.0;
    end.B = 174 / 255.0;
    
    UIImage *normalImage = [self.voiceInputButton linearGradientImage:begin end:end];
    UIImage *highlightImage = [self.voiceInputButton linearGradientImage:end end:begin];
    
    [self.voiceInputButton setBackgroundImage:normalImage forState:UIControlStateNormal];
    [self.voiceInputButton setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [self.voiceInputButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    panel = [[UIScrollView alloc]initWithFrame:CGRectZero];
    panel.pagingEnabled = TRUE;
    
    
    [self setBackgroundColor:[UIColor blackColor]];
    
    [self addSubview:leftButton];
    [self addSubview:rightButton];
    [self addSubview:sendButton];
    [self addSubview:inputTextField];
    [self addSubview:voiceInputButton];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self configUserInterface];
        [self configFacialEmotions];
        
        // 默认普通类型输入
        inputType = InputType_Common;
        inputVoiceType= InputVoiceType_Record;
        
        firstSetUp = TRUE;

        originViewFrame = frame;
        
     
         }
    return self;
}

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)resetDefaultStyle {
    self.inputType = InputType_Common;
    [self setNeedsLayout];
}


// 隐藏Panel视图
- (void)hidePanelView {
    if (facialView) {
        [facialView setHidden:TRUE];
    }
    
    if (facialEmotionViews != NULL && [facialEmotionViews count] > 0) {
        for (YAFacialEmotionView *view in facialEmotionViews) {
            [view setHidden:true];
        }
    }
    
    if (chattingVoiceView) {
        [chattingVoiceView setHidden:TRUE];
    }
    // Reset panel content size
    self.panel.contentSize = CGSizeMake(CGRectGetWidth(self.panel.frame) , CGRectGetHeight(self.panel.frame));
}

// 设置普通输入模式视图
- (void)setCommonInputView {
    
    // 初次加载界面视图时，不需要设置InputView。
    if (firstSetUp == TRUE) {
        firstSetUp = false;
    }
    else {
        [self.inputTextField resignFirstResponder];
        self.inputTextField.inputView = nil;
        //[self.inputTextField becomeFirstResponder];
        
    }
    
    [self.inputTextField setHidden:FALSE];
    [self.voiceInputButton setHidden:TRUE];

}

// 设置其他输入模式视图
- (void)setFacialInputView {
    [self.panel setFrame:CGRectMake(0, 0, self.frame.size.width, FACIAL_PANEL_HEIGHT)];
    
    if (!facialView) {
        facialView = [[YAFacialView alloc]initWithDelegate:self];
        [facialView setFrame:CGRectMake(0, 0,CGRectGetWidth(self.panel.frame),CGRectGetHeight(self.panel.frame))];
        [self.panel addSubview:facialView];
        
    }
    [facialView setHidden:false];
    [self.inputTextField resignFirstResponder];
    self.inputTextField.inputView = self.panel;
    [self.inputTextField becomeFirstResponder];
    
    [self.inputTextField setHidden:FALSE];
    [self.voiceInputButton setHidden:TRUE];

}

// 设置声音输入模式视图
- (void)setVoiceInputView {
    
    if (inputVoiceType == InputVoiceType_Record) {
         [self.panel setFrame:CGRectMake(0, 0, self.frame.size.width, 0)];
        [self.inputTextField setHidden:TRUE];
        [self.voiceInputButton setHidden:FALSE];
    
    }
    else if(inputVoiceType == InputVoiceType_RealTime) {
        
        if (!chattingVoiceView) {
            chattingVoiceView = [[YAChattingVoiceView alloc]init];
            [chattingVoiceView setFrame:CGRectMake(0, 0, self.frame.size.width, VOICE_PANEL_HEIGHT)];
            [chattingVoiceView setDelegate:self];
         
        }
        [self.panel setFrame:CGRectMake(0, 0, self.frame.size.width, VOICE_PANEL_HEIGHT)];
        [self.panel addSubview:chattingVoiceView];
        [chattingVoiceView setHidden:false];
       
    }
    
    
  
    [self.inputTextField resignFirstResponder];
    self.inputTextField.inputView = self.panel;
    [self.inputTextField becomeFirstResponder];
    
}

// 设置表情输入模式视图
- (void)setFacialEmotionInputView {
    [self.panel setFrame:CGRectMake(0, 0, self.frame.size.width, FACIAL_EMOTION_PANEL_HEIGHT)];
    
    if (!facialEmotionViews) {
        facialEmotionViews = [[NSMutableArray alloc]init];
        NSUInteger i = 0;
        for ( i = 0;i < emotionsArray.count; i++) {
            YAFacialEmotionView *emotionView = [[YAFacialEmotionView alloc]initWithRow:3 Col:7 andEmotions:[emotionsArray objectAtIndex:i] andEmotionsKey:[emotionsKeyArray objectAtIndex:i]];
            [emotionView setDelegate:self];
            [emotionView setFrame:CGRectMake(i * CGRectGetWidth(self.panel.frame) , 0, CGRectGetWidth(self.panel.frame),CGRectGetHeight(self.panel.frame))];
            [self.panel addSubview:emotionView];
            [facialEmotionViews addObject:emotionView];
            
        }
        
       
    }
    
    if (facialEmotionViews != NULL && [facialEmotionViews count] > 0) {
        for (YAFacialEmotionView *view in facialEmotionViews) {
            [view setHidden:false];
        }
    }
    
    self.panel.contentSize = CGSizeMake(CGRectGetWidth(self.panel.frame) * (emotionsArray.count ), CGRectGetHeight(self.panel.frame));
    
    [self.inputTextField resignFirstResponder];
    self.inputTextField.inputView = self.panel;
    [self.inputTextField becomeFirstResponder];
}

// 设置图片输入视图
-(void)setFacialPhotoInputView {
    [facialView setHidden:false];
    
}

- (void)layoutSubviews {
   

    // Hidden all view in panel
    [self hidePanelView];
    
    if (inputType == InputType_Common) {
        [self setCommonInputView];
        [leftButton setImage:[UIImage imageNamed:@"btn_voice_press.png"] forState:UIControlStateHighlighted];
        [leftButton setImage:[UIImage imageNamed:@"btn_voice.png"] forState:UIControlStateNormal];
        [rightButton setImage:[UIImage imageNamed:@"btn_open_press.png"] forState:UIControlStateHighlighted];
        [rightButton setImage:[UIImage imageNamed:@"btn_open.png"] forState:UIControlStateNormal];
    }
    else if(inputType == InputType_Facial) {
        [self setFacialInputView];
        [rightButton setImage:[UIImage imageNamed:@"btn_close_press.png"] forState:UIControlStateHighlighted];
        [rightButton setImage:[UIImage imageNamed:@"btn_close.png"] forState:UIControlStateNormal];
        [leftButton setImage:[UIImage imageNamed:@"btn_voice_press.png"] forState:UIControlStateHighlighted];
        [leftButton setImage:[UIImage imageNamed:@"btn_voice.png"] forState:UIControlStateNormal];
    }
    else if(inputType == InputType_Voice){
        [self setVoiceInputView];
        [leftButton setImage:[UIImage imageNamed:@"btn_keyboard_press.png"] forState:UIControlStateHighlighted];
        [leftButton setImage:[UIImage imageNamed:@"btn_keyboard.png"] forState:UIControlStateNormal];
        
        
    }
    else if(inputType == InputType_Facial_Emotion) {
        [self setFacialEmotionInputView];
    }
    else if(inputType == InputType_Facial_Photo) {
        [self setFacialPhotoInputView];
    }
    
    NSLog(@"[Type Input]:%d",inputType);
} 

#pragma mark user event
- (IBAction)sendButtonClick:(id)sender {
    
    NSLog(@"[Send Button Click]");
}

- (IBAction)leftButtonClick:(id)sender {
    NSLog(@"[Left Button Click]");
    
    if (inputType == InputType_Common)
        inputType = InputType_Voice;
    
    else if(inputType == InputType_Facial
            ||inputType == InputType_Facial_Emotion
            || inputType == InputType_Facial_Photo)
        
        inputType = InputType_Voice;
    
    else if(inputType == InputType_Voice)
        inputType = InputType_Common;

    [self setNeedsLayout];
}

- (IBAction)rightButtonClick:(id)sender {
    NSLog(@"[Right Button Click]");
    
    if (inputType == InputType_Facial
        || inputType == InputType_Facial_Emotion
        || inputType == InputType_Facial_Photo) {
        inputType = InputType_Common;
    }
    else {
        inputType = InputType_Facial;
    }
  
     [self setNeedsLayout];
}

- (IBAction)voiceInputTouchDown:(id)sender {
    
    NSLog(@"[voice input touch down]");
}

- (IBAction)voiceInputTouchUpInside:(id)sender {
    NSLog(@"[voice input touch up inside]");
}

// When touch in text field , change inputview to default ( keyboard)
- (void)handleTapInTextField {
    if (self.inputTextField.inputView == nil) {
        return; // Do nothing
    }
    else {
        self.inputTextField.inputView = nil;
        [self.inputTextField resignFirstResponder];
        [self.inputTextField becomeFirstResponder];
    }
}


#pragma mark UITextFieldDelegate


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"[textFieldDidBeginEditing]");

}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"[textFieldDidEndEditing]");
    NSLog(@"[Input] %@",textField.text);
   
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        if (delegate != nil) {
            [delegate didSendMessage:textField.text];
        }
        
        textField.text = @"";
        
        return NO;
    }
    return YES;
}

#pragma mark YAFacialTypeDelegate
- (void)didSelectedIndex:(YAFacialView *)obj facialType:(FacialType)facialType {
    NSLog(@"[Select Facial Type]%d",facialType);
    inputType = (facialType == FacialType_Emotion ? InputType_Facial_Emotion : InputType_Facial_Photo);
    [self setNeedsLayout];
    
    if (inputType == InputType_Facial_Photo) {
        // Open local photo
        
    }
    
}

#pragma mark YAFacialEmotionViewDelegate

- (void)didSelectedEmotions:(YAFacialEmotionView *)obj index:(NSUInteger)index value:(NSString *)value {
    NSLog(@"[Select Emoj ] %d , %@",index,value);
    
    if ([value isEqualToString:@"[del]"]) {
        [inputTextField deleteBackward];
    }
    else {
        NSMutableString *str = [[NSMutableString alloc]init];
        [str appendString:inputTextField.text];
        [str appendString:value];
        inputTextField.text = str;
    }
}

#pragma mark YAChattingVoiceViewDelegate
- (void)didVoiceInputBtnTouchDown:(YAChattingVoiceView *)view {
    NSLog(@"[RealTime voice input btn Touch down]");
    
    [view startChattingAnimation];
}


- (void)didVoiceInputBtnTouchUp:(YAChattingVoiceView *)view {
       NSLog(@"[RealTime voice input btn Touch Up]");
    
    [view stopChattingAnimation];
}

@end
