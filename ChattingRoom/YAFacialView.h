//
//  YAFacialView.h
//  ChattingRoom
//
//  Created by wind on 4/29/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FacialType_{
    FacialType_Emotion,FacialType_Photo
}FacialType;

@class YAFacialView;

@protocol YAFacialViewDelegate <NSObject>
- (void)didSelectedIndex:(YAFacialView *)obj facialType:(FacialType)facialType;
@end


                          
@interface YAFacialView : UIView

- (id)initWithDelegate:(NSObject <YAFacialViewDelegate> *)_delegate;
@end
