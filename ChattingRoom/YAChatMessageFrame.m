//
//  YAChatMessageFrame.m
//  ChattingRoom
//
//  Created by wind on 5/8/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAChatMessageFrame.h"
#import "YARichText.h"
#import "YAChatMessage.h"

#define NSLog(...)                                      {}
/* 头像宽高 */
#define kContentNickIconWH                              50
/*信息字体*/
#define kContentInfoFont                                [UIFont systemFontOfSize:12]
/*头像左右外边距*/
#define kContentNickIconMarginLeftRight                 10
/*头像上外边距*/
#define kContentNickIconMarginTop                       10
/*信息左右外边距*/
#define kContentInfoMarginLeftRight                     10
/*信息内容上边距*/
#define kContentInfoMarginTop                           10
/*气泡上外边距*/
#define kContentBubbleMarginTop                         10
/*气泡左右外边距*/
#define kContentbubbleMarginLeftRight                   10
/*内容容器宽*/
#define kContentContainerContentWidth                   220
/*内容容器左右外边距*/
#define kContentContainerMarginLeftRight                10
/*内容容器上边距*/
#define kContentContainerMarginTop                      10
/*内容富文本宽*/
#define kContentContainerRichTextWidth                  200
/*内容富文本左外边距*/
#define kContentContainerRichTextMarginLeft             10
/*内容富文本右外边距*/
#define kContentContainerRichTextMarginRight            10
/*内容富文本上外边距*/
#define kContentContainerRichTextMarginTop              10
/*内容富文本下外边距*/
#define kContentContainerRichTextMarginBottom           10



@implementation YAChatMessageFrame
@synthesize chatMessage = _chatMessage,height;
@synthesize rectContent,rectContentRichText,rectNickIcon,rectNickName,rectTimeStamp;


- (id)initWithMesssage:(YAChatMessage *)message {
    if (self = [super init]) {
        [self setChatMessage:message];
    }
    return self;
}

- (void)setChatMessage:(YAChatMessage *)chatMessage {
    
    _chatMessage = chatMessage;
    
    YAMessageStyle style = _chatMessage.messageStyle;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;

    // Set nick icon frame
    rectNickIcon =  CGRectMake(0, kContentNickIconMarginTop, kContentNickIconWH, kContentNickIconWH);
    
    if (style == YAMessageStyleLeft) {
        rectNickIcon.origin.x += kContentNickIconMarginLeftRight;
        rectNickIcon.size = CGSizeMake(kContentNickIconWH, kContentNickIconWH);
    }
    else {
        rectNickIcon.origin.x = screen_width - kContentNickIconMarginLeftRight - kContentNickIconWH;
        rectNickIcon.size = CGSizeMake(kContentNickIconWH, kContentNickIconWH);
    }
  
    // Set nickname , nickstamp frame
    CGSize sizeNickName = [_chatMessage.nickName sizeWithFont:kContentInfoFont];
    CGSize sizeTimeStamp = [_chatMessage.timeStr sizeWithFont:kContentInfoFont];
    
    rectNickName = CGRectMake(0,kContentInfoMarginTop , sizeNickName.width, sizeNickName.height);
    rectTimeStamp = CGRectMake(0, kContentBubbleMarginTop, sizeTimeStamp.width, sizeTimeStamp.height);
    
    if (style == YAMessageStyleLeft) {
        rectNickName.origin.x = CGRectGetMaxX(rectNickIcon) + kContentInfoMarginLeftRight;
        rectTimeStamp.origin.x = CGRectGetMaxX(rectNickName) + kContentInfoMarginLeftRight;
    }
    else {
        rectTimeStamp.origin.x = CGRectGetMinX(rectNickIcon) - kContentInfoMarginLeftRight - sizeTimeStamp.width;
        rectNickName.origin.x = CGRectGetMinX(rectTimeStamp) - kContentInfoMarginLeftRight - sizeNickName.width;
    }
    
    YARichText *richText = [[YARichText alloc]init];
    [richText setText:_chatMessage.content];
    
    rectContent = CGRectMake(0, CGRectGetMaxY(rectNickName) + kContentContainerMarginTop, kContentContainerContentWidth , 0);
    
    if (style == YAMessageStyleLeft) {
        rectContent.origin.x = CGRectGetMaxX(rectNickIcon) + kContentContainerMarginLeftRight;
        rectContent.size.height =  [richText sizeOfRichText].height + kContentContainerRichTextMarginTop + kContentContainerRichTextMarginBottom;
    }
    else {
        rectContent.origin.x = CGRectGetMinX(rectNickIcon) - kContentContainerMarginLeftRight - kContentContainerContentWidth;
        rectContent.size.height = [richText sizeOfRichText].height + kContentContainerRichTextMarginTop + kContentContainerRichTextMarginBottom;
    }
 
     rectContentRichText = CGRectMake(kContentContainerRichTextMarginLeft,
                                            kContentContainerRichTextMarginTop,
                                            rectContent.size.width - (kContentContainerRichTextMarginLeft + kContentContainerRichTextMarginRight),[richText sizeOfRichText].height);
    
    height = CGRectGetMaxY(rectNickIcon) > CGRectGetMaxY(rectContent) ?  CGRectGetMaxY(rectNickIcon) :  CGRectGetMaxY(rectContent);
    
    NSLog(@"[nick icon frame] %@ \n",NSStringFromCGRect(rectNickIcon));
    NSLog(@"[nick name frame] %@ \n",NSStringFromCGRect(rectNickName));
    NSLog(@"[time stamp frame] %@ \n",NSStringFromCGRect(rectTimeStamp));
    NSLog(@"[content frame] %@ \n",NSStringFromCGRect(rectContent));
    NSLog(@"[content richtext frame] %@ \n",NSStringFromCGRect(rectContentRichText));
    
}


@end
