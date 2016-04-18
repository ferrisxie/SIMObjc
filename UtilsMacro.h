//
//  UtilsMacro.h
//  SIMChat
//
//  Created by Ferris on 15/8/15.
//  Copyright (c) 2015年 Ferris. All rights reserved.
//
#ifndef SIMChat_UtilsMacro_h
#define SIMChat_UtilsMacro_h
/**
 *  通用宏定义
 *
 */

#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define EnableLog YES
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]
// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CoreDataKeyChangeDate @"changeDate"
#define mainThemeColor  [UIColor colorWithRed:98.0f/255.0f green:173.0f/255.0f blue:237.0f/255.0f alpha:1.0f]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


#define navigationBarColor RGB(33, 192, 174)
#define separaterColor RGB(200, 199, 204)


// 3.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 4.屏幕大小尺寸
#define screen_width [UIScreen mainScreen].bounds.size.width
#define screen_height [UIScreen mainScreen].bounds.size.height

//重新设定view的Y值
#define setFrameY(view, newY) view.frame = CGRectMake(view.frame.origin.x, newY, view.frame.size.width, view.frame.size.height)
#define setFrameX(view, newX) view.frame = CGRectMake(newX, view.frame.origin.y, view.frame.size.width, view.frame.size.height)
#define setFrameH(view, newH) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, newH)
#define setFrameW(view, newW) view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, newW, view.frame.size.height)

//取view的坐标及长宽
#define W(view)    view.frame.size.width
#define H(view)    view.frame.size.height
#define X(view)    view.frame.origin.x
#define Y(view)    view.frame.origin.y
/**
 *  项目相关
 */
#define mainColor  [UIColor colorWithRed:0.000 green:0.698 blue:0.933 alpha:1.000]
#define mainTintColor  [UIColor colorWithRed:0.267 green:0.765 blue:0.933 alpha:1.000]
#define mainBarColor  [UIColor colorWithRed:0.000 green:0.558 blue:0.747 alpha:1.000]
#define mainButtonColor  [UIColor colorWithRed:0.933 green:0.235 blue:0.000 alpha:1.000]
#define mainFont [UIFont fontWithName:@"AppleSDGothicNeo-Regular" size:10.0]

#define serviceAddress @"http://objc.xferris.me/objc"
#endif
