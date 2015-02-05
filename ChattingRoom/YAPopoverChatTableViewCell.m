//
//  YAPopoverChatTableViewCell.m
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "YAPopoverChatTableViewCell.h"
#import "YAPopoverChatTableViewCellBubbleView.h"


// 内容字体
#define kContentInfoFont           [UIFont systemFontOfSize:12]


@implementation YAPopoverChatTableViewCell {
     
 
}

@synthesize messageFrame = _messageFrame;
@synthesize nickIconImageView,nickNameLabel,content,timeStampLabel,richText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        

        self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.textLabel.hidden = YES;
        
        nickIconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        nickNameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        timeStampLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        content = [[UIImageView alloc]initWithFrame:CGRectZero];
        richText = [[YARichText alloc]init];
        
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

- (void)setMessageFrame:(YAChatMessageFrame *)messageFrame {
    _messageFrame = messageFrame;
    
    [nickIconImageView setImage:[UIImage imageNamed:messageFrame.chatMessage.iconUrl]];
    [nickIconImageView setFrame:messageFrame.rectNickIcon];
    
    [nickNameLabel setText:messageFrame.chatMessage.nickName];
    [nickNameLabel setFrame:messageFrame.rectNickName];
    
    [timeStampLabel setText:messageFrame.chatMessage.timeStr];
    [timeStampLabel setFrame:messageFrame.rectTimeStamp];
    
    [content setFrame:messageFrame.rectContent];
    
    [richText setText:messageFrame.chatMessage.content];
    [richText setFrame:messageFrame.rectContentRichText];

    UIImage *normal ;
    if (messageFrame.chatMessage.messageStyle == YAMessageStyleLeft) {
    
        normal = [UIImage imageNamed:@"chat_message_left_bg.png"];
        //normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
            }else{
    
        normal = [UIImage imageNamed:@"chat_message_right_bg.png"];
        normal = [normal stretchableImageWithLeftCapWidth:normal.size.width * 0.5 topCapHeight:normal.size.height * 0.5];
    
    }
    
    [content setImage:normal];
  
   }

- (void)awakeFromNib
{
    // Initialization code
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
 
 

@end
