//
//  YAFacialView.m
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAFacialEmotionView.h"



@implementation YAFacialEmotionView {
    NSInteger  __row;
    NSInteger  __col;
   
   __strong NSArray   *__emotions;
   __strong NSArray  *__emotionsKey;
    
}

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithRow:(NSInteger)row Col:(NSInteger)col andEmotions:(NSArray *)emotions andEmotionsKey:(NSArray *)emotionsKey{
    
    if (self = [super init]) {
        __row = row;
        __col = col;
        __emotions = emotions;
        __emotionsKey = emotionsKey;
    }
    
    return self;
}

- (void)layoutSubviews {
    
    CGRect rect = self.frame;
    
    float divide_x = rect.size.width / __col;
    float divide_y = rect.size.height / __row;
    float margin = 5;
    
    float width = divide_x - margin * 2;
    float height = divide_y - margin * 2;
    
  
    for (NSInteger i = 0; i < __row * __col; i++) {
            CGRect _rect = CGRectMake((i % __col) * divide_x + margin, i / __col * divide_y + margin, width,height);
            UIButton *emoButton = [[UIButton alloc]initWithFrame:_rect];
            [emoButton addTarget:self action:@selector(emoButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            emoButton.tag = i;
        
            if(i == __row * __col - 1) {
                [emoButton setImage:[UIImage imageNamed:@"face_del_icon_n.png"] forState:UIControlStateNormal];
                [emoButton setImage:[UIImage imageNamed:@"face_del_icon_p.png"] forState:UIControlStateHighlighted];
            }
            else
            [emoButton setImage:[UIImage imageNamed:[__emotions objectAtIndex:i]] forState:UIControlStateNormal];
        
            [self addSubview:emoButton];
        }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)emoButtonClick:(id)sender {
    
    NSUInteger tag = ((UIButton *)sender).tag;
    
    if (delegate != NULL) {
        [delegate didSelectedEmotions:self index:tag value:[__emotionsKey objectAtIndex:tag]];
    }
    
}

@end
