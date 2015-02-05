//
//  UIButton+Bootstrap.m
//  ChattingRoom
//
//  Created by wind on 5/4/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#import "UIButton+Bootstrap.h"
#import <QuartzCore/QuartzCore.h>


@implementation UIButton (Bootstrap)
 

- (UIImage *)linearGradientImage:(rgb_value_t)start end:(rgb_value_t)end {
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, TRUE, 1.0);
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGGradientRef glossGradient;
    CGColorSpaceRef rgbColorspace;
    size_t numLocations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    
    //Two colour components, the start and end colour both set to opaque.
    CGFloat components[8] = { start.R, start.G, start.B, 1.0, end.R, end.G, end.B, 1.0 };
    
    rgbColorspace = CGColorSpaceCreateDeviceRGB();
    glossGradient = CGGradientCreateWithColorComponents(rgbColorspace, components, locations, numLocations);
    
    CGRect currentBounds = self.bounds;
    CGPoint topCenter = CGPointMake(CGRectGetMidX(currentBounds), 0.0f);
    CGPoint bottomCenter = CGPointMake(CGRectGetMidX(currentBounds), CGRectGetMaxY(currentBounds));
    
    // Draw
    CGContextDrawLinearGradient(currentContext, glossGradient, topCenter, bottomCenter, 0);
   
    CGGradientRelease(glossGradient);
    CGColorSpaceRelease(rgbColorspace);
    
    __strong UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (UIImage *) buttonImageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
