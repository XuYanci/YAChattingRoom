//
//  YAPopoverChatTableViewCellBubbleView.m
//  ChattingRoom
//
//  Created by wind on 5/7/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAPopoverChatTableViewCellBubbleView.h"


// 头像高和宽
#define kContentNickIconWH         50

// 内容字体
#define kContentInfoFont           [UIFont systemFontOfSize:12]


#define kContentNickIconMarginLeftRight     10
#define kContentNickIconMarginTop           10

#define kContentInfoMarginLeftRight         10
#define kContentInfoMarginTop               10


#define kContentBubbleMarginTop             10
#define kContentbubbleMarginLeftRight       10

#define kContentContainerContentWidth         170
#define kContentContainerMarginLeftRight      10
#define kContentContainerMarginTop            10

#define kContentContainerRichTextWidth         150
#define kContentContainerRichTextMarginLeft     10
#define kContentContainerRichTextMarginRight    10
#define kContentContainerRichTextMarginTop      10


@implementation YAPopoverChatTableViewCellBubbleView {
    YARichText *richText;
}
@synthesize nickNameLabel,nickIconImageView,timeStampLabel,content,style;
@synthesize message,bubbleViewHeight;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        nickIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        nickNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeStampLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        content = [[UIView alloc]initWithFrame:CGRectZero];
        richText = [[YARichText alloc]initWithString:@""];
        
        [self addSubview:nickNameLabel];
        [self addSubview:nickIconImageView];
        [self addSubview:timeStampLabel];
        [self addSubview:content];
        [content addSubview:richText];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [nickNameLabel setFont:kContentInfoFont];
        [timeStampLabel setFont:kContentInfoFont];
    }
    return self;
}

- (void)layoutSubviews {
    
   
}

- (void)setStyle:(YAMessageStyle)style {
    
    CGRect _rect = self.bounds;
    
    // Set nick icon frame
    CGRect rectNickIcon =  CGRectMake(0, kContentNickIconMarginTop, kContentNickIconWH, kContentNickIconWH);
    
    if (style == YAMessageStyleLeft) {
        rectNickIcon.origin.x += kContentNickIconMarginLeftRight;
        rectNickIcon.size = CGSizeMake(kContentNickIconWH, kContentNickIconWH);
    }
    else {
        rectNickIcon.origin.x = _rect.size.width - kContentNickIconMarginLeftRight - kContentNickIconWH;
        rectNickIcon.size = CGSizeMake(kContentNickIconWH, kContentNickIconWH);
    }

    NSLog(@"[nick icon frame] %@",NSStringFromCGRect(rectNickIcon));
    
    [nickIconImageView setFrame:rectNickIcon];
    
    // Set nickname , nickstamp frame
    CGSize sizeNickName = [message.nickName sizeWithFont:kContentInfoFont];
    CGSize sizeTimeStamp = [message.timeStr sizeWithFont:kContentInfoFont];
    
    CGRect rectNickName = CGRectMake(0,kContentInfoMarginTop , sizeNickName.width, sizeNickName.height);
    CGRect rectTimeStamp = CGRectMake(0, kContentBubbleMarginTop, sizeTimeStamp.width, sizeTimeStamp.height);
    
    if (style == YAMessageStyleLeft) {
        rectNickName.origin.x = CGRectGetMaxX(rectNickIcon) + kContentInfoMarginLeftRight;
        rectTimeStamp.origin.x = CGRectGetMaxX(rectNickName) + kContentInfoMarginLeftRight;
    }
    else {
        rectTimeStamp.origin.x = CGRectGetMinX(rectNickIcon) - kContentInfoMarginLeftRight - sizeTimeStamp.width;
        rectNickName.origin.x = CGRectGetMinX(rectTimeStamp) - kContentInfoMarginLeftRight - sizeNickName.width;
    }
    
    NSLog(@"[nickname frame] %@",NSStringFromCGRect(rectNickName));
    NSLog(@"[timestamp frame] %@",NSStringFromCGRect(rectTimeStamp));
    
    [nickNameLabel setFrame:rectNickName];
    [timeStampLabel setFrame:rectTimeStamp];
    
    // Set content frame
    CGRect rectContent = CGRectMake(0, CGRectGetMaxY(rectNickName) + kContentContainerMarginTop, kContentContainerContentWidth , 0);
   
    [content setFrame:rectContent];
}


- (void)setMessage:(YAChatMessage *)message {
    
    [richText setText:message.content];
    [richText build];
 
    CGRect rectContent = CGRectMake(0, CGRectGetMaxY(self.nickNameLabel.frame) + kContentContainerMarginTop, kContentContainerContentWidth , 0);
    
    if (style == YAMessageStyleLeft) {
        rectContent.origin.x = CGRectGetMaxX(self.nickIconImageView.frame) + kContentContainerMarginLeftRight;
        rectContent.size.height = CGRectGetHeight(richText.frame) + kContentContainerRichTextMarginTop;
    }
    else {
        rectContent.origin.x = CGRectGetMinX(self.nickIconImageView.frame) - kContentContainerMarginLeftRight - kContentContainerContentWidth;
        rectContent.size.height = CGRectGetHeight(richText.frame) + kContentContainerRichTextMarginTop;
    }
    NSLog(@"[Content Container Frame]%@",NSStringFromCGRect(rectContent));
    [content setFrame:rectContent];
    
    
    CGRect rectContentRichText = CGRectMake(kContentContainerRichTextMarginLeft,
                                            kContentContainerRichTextMarginTop,
                                            rectContent.size.width - (kContentContainerRichTextMarginLeft + kContentContainerRichTextMarginRight), richText.frame.size.height);
    
    [richText setFrame:rectContentRichText];
  

}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
// 
//   
//    
//}


@end
