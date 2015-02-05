//
//  YARichText.h
//  ChattingRoom
//
//  Created by wind on 5/5/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YARichText : UIView

@property (nonatomic,strong) NSString* text;
@property (nonatomic,assign) CGFloat textFontSize;
@property (nonatomic,assign) CGFloat textWidth;

- (id)init;

- (CGSize)sizeOfRichText;
 
@end
