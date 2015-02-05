//
//  UIButton+Bootstrap.h
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct RGB_{
    float R,G,B;
}rgb_value_t;


@interface UIButton (Bootstrap)

- (UIImage *)buttonImageFromColor:(UIColor *)color;
- (UIImage *)linearGradientImage:(rgb_value_t)start end:(rgb_value_t)end;


@end
