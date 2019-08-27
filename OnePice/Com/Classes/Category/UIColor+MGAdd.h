//
//  UIColor+MGAdd.h
//  MGKit
//
//  Created by mac on 2018/7/28.
//

#import <UIKit/UIKit.h>

@interface UIColor (MGAdd)

/**
 APP主题色
 */
+ (UIColor *)appMainColor;
/**
 APP主题内部字体色
 */
+ (UIColor *)appMainDescribeColor;
/**
 导航栏背景颜色
 */
+ (UIColor *)appNavBarBgColor;

/**
 Tab栏背景颜色
 */
+ (UIColor *)appTabBarBgColor;

/**
 APP内容背景色
 */
+ (UIColor *)appBackgroundColor;

/**
 APP主标题颜色
 */
+ (UIColor *)appTitleColor;

/**
 APP副标题颜色
 */
+ (UIColor *)appSubTitleColor;

/**
 APP按钮背景色
 */
+ (UIColor *)appButtonBgColor;

/**
 APP按钮不可用背景色
 */
+ (UIColor *)appButtonGrayBgColor;

+ (UIColor *)appYellowColor;

+ (UIColor *)appGrayColor;

+ (UIColor *)appRedColor;

@end
