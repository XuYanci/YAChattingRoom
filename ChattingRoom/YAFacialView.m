//
//  YAFacialView.m
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAFacialView.h"

#define  BUTTON_WH          80

@implementation YAFacialView {
    __strong UIButton *emotButton;
    __strong UIButton *photoButton;
    __strong UILabel  *emotLabel;
    __strong UILabel  *photoLabel;
    
    __strong  NSObject <YAFacialViewDelegate> *delegate;
}

- (id)initWithDelegate:(NSObject <YAFacialViewDelegate> *)_delegate {
    if (self = [super init]) {
        delegate = _delegate;
        emotButton = [[UIButton alloc]initWithFrame:CGRectZero];
        photoButton = [[UIButton alloc]initWithFrame:CGRectZero];
        
        [emotButton setBackgroundImage:[UIImage imageNamed:@"btn_face_n.png"] forState:UIControlStateNormal];
        [emotButton setBackgroundImage:[UIImage imageNamed:@"btn_face_p.png"] forState:UIControlStateHighlighted];
        
        [photoButton setBackgroundImage:[UIImage imageNamed:@"btn_picture_n.png"] forState:UIControlStateNormal];
        [photoButton setBackgroundImage:[UIImage imageNamed:@"btn_picture_p.png"] forState:UIControlStateHighlighted];
        


        emotLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        photoLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        
        [emotLabel setText:@"表情"];
        [photoLabel setText:@"图片"];
        
        
        
        emotButton.tag = FacialType_Emotion;
        photoButton.tag = FacialType_Photo;
        
        [emotButton addTarget:self action:@selector(facialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [photoButton addTarget:self action:@selector(facialBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:emotButton];
        [self addSubview:emotLabel];
        [self addSubview:photoButton];
        [self addSubview:photoLabel];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)layoutSubviews {
    
    //CGRect rect = self.frame;
    
    float margin = 15;
    
    [emotButton setFrame:CGRectMake(20, 10, BUTTON_WH, BUTTON_WH)];
    [emotLabel setFrame:CGRectMake(20, 10 + BUTTON_WH, BUTTON_WH, BUTTON_WH)];
    
    [photoButton setFrame:CGRectMake(20 + BUTTON_WH + margin * 2, 10, BUTTON_WH, BUTTON_WH)];
    [photoLabel setFrame:CGRectMake(20 + BUTTON_WH + margin * 2, 10 + BUTTON_WH, BUTTON_WH, BUTTON_WH)];
}

- (IBAction)facialBtnClick:(id)sender {
    if (delegate) {
        [delegate didSelectedIndex:self facialType: ((UIButton *)sender).tag];
    }
}

@end
