//
//  YAFacialView.h
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YAFacialEmotionView;

@protocol YAFacialEmotionViewDelegate <NSObject>

- (void)didSelectedEmotions:(YAFacialEmotionView *)obj index:(NSUInteger)index value:(NSString *)value;

@end


@interface YAFacialEmotionView : UIView
@property (nonatomic,weak) NSObject <YAFacialEmotionViewDelegate> * delegate;

- (id)initWithRow:(NSInteger)row Col:(NSInteger)col andEmotions:(NSArray *)emotions andEmotionsKey:(NSArray *)emotionsKey;

@end
