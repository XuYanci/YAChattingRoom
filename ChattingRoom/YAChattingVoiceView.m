//
//  YAChattingVoiceView.m
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAChattingVoiceView.h"
#import "chatroom_public.h"

@implementation YAChattingVoiceView {
    dispatch_source_t _timer;
    NSInteger  animationCounter;
}
@synthesize voiceButton,delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        voiceButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [voiceButton setImage:[UIImage imageNamed:@"btn_team_voice_animate_1.png"] forState:UIControlStateNormal];
        [voiceButton addTarget:self action:@selector(voiceButtonTouchDown:) forControlEvents:UIControlEventTouchDown];
        [voiceButton addTarget:self action:@selector(voiceButtonTouchUp:) forControlEvents:UIControlEventTouchUpInside];
        [voiceButton addTarget:self action:@selector(voiceButtonTouchUp:) forControlEvents:UIControlEventTouchDragOutside];
        
        voiceButton.imageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"btn_team_voice_animate_1.png"], [UIImage imageNamed:@"btn_team_voice_animate_2.png"], [UIImage imageNamed:@"btn_team_voice_animate_3.png"],nil];
        voiceButton.imageView.animationRepeatCount = 0;
        voiceButton.imageView.animationDuration = 1.0;
        
        [self addSubview:voiceButton];
    }
    return self;
}


- (void)layoutSubviews {
    [voiceButton setCenter:self.center];
}


- (IBAction)voiceButtonTouchDown:(id)sender {
    if (delegate != nil) {
        [delegate didVoiceInputBtnTouchDown:self];
    }
}

- (IBAction)voiceButtonTouchUp:(id)sender {
  
    if (delegate != nil) {
        [delegate didVoiceInputBtnTouchUp:self];
    }
}

- (void)startChattingAnimation {
    [voiceButton.imageView startAnimating];
}

- (void)stopChattingAnimation {
    [voiceButton.imageView stopAnimating];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/




@end
