//
//  public.h
//  ChattingRoom
//
//  Created by wind on 4/30/14.
//  Copyright (c) 2014 wind. All rights reserved.
//

#ifndef ChattingRoom_public_h
#define ChattingRoom_public_h

///////////////////////////////////////// Config /////////////////////////////////////////
#define UseInputDialog                     (1)             /*是否使用输入框*/



///////////////////////////////////////// Adapter Helper /////////////////////////////////////////

/* 判断是否IOS 7 */
#define IsIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

/* 判断是否 Retina 屏幕 */
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960),[[UIScreen mainScreen] currentMode].size) : NO)

/* 判断是否 iPhone5 */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136),[[UIScreen mainScreen] currentMode].size) : NO)

/* 判断是否iPad */
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

///////////////////////////////////////// Params /////////////////////////////////////////

/* 导航条高度 */
#define  NavigationBarHeight        44

/* 状态栏高度 */
#define  StatusBarHeight            [[UIApplication sharedApplication]statusBarFrame].size.height


///////////////////////////////////////// Func /////////////////////////////////////////

/* 打印 Frame */
#define LogFrame(frame) NSLog(@"frame[X=%.1f,Y=%.1f,W=%.1f,H=%.1f",frame.origin.x,      \
                                                                    frame.origin.y,     \
                                                                    frame.size.width,   \
                                                                    frame.size.height)

#endif
