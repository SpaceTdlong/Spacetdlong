//
//  HuGeComConfig.h
//  ESportsCom
//
//  Created by sam on 2019/4/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeComConfig : NSObject

#pragma mark - APP主题色的配置
/**
 APP主题色
 */
@property (nonatomic, strong) UIColor *appMainColor;
/**
 APP主题内部字体色
 */
@property (nonatomic, strong) UIColor *appMainDescribeColor;
/**
 导航栏背景颜色
 */
@property (nonatomic, strong) UIColor *appNavBarBgColor;

/**
 Tab栏背景颜色
 */
@property (nonatomic, strong) UIColor *appTabBarBgColor;

/**
 APP内容背景色
 */
@property (nonatomic, strong) UIColor *appBackgroundColor;

/**
 APP主标题颜色
 */
@property (nonatomic, strong) UIColor *appTitleColor;

/**
 APP副标题颜色
 */
@property (nonatomic, strong) UIColor *appSubTitleColor;

/**
 APP按钮背景色
 */
@property (nonatomic, strong) UIColor *appButtonBgColor;

/**
 APP按钮不可用背景色
 */
@property (nonatomic, strong) UIColor *appButtonGrayBgColor;

#pragma mark - APP Icon
/**
 app icon, 大小100*100pt, 比传
 */
@property (nonatomic, strong) UIImage *appIcon100;

/**
 是否使用用户模块，默认YES --> TODO, 没利用起来
 如果使用用户模块，则APP必须包含用户登录注册模块，各模块中支持用户收藏，点赞等操作。
 如果不使用用户模块，则各模块中跟用户操作相关的功能要隐藏
 */
@property (nonatomic, assign) BOOL isUseUserModule;

#pragma mark - Base Url

/**
 全局域名配置，如果无需配置，默认使用：http://api.ourgameapi.com
 如果是兼职模块，需要配置为：http://jianzhi.ourgameapi.com
 */
@property (nonatomic, copy) NSString *baseUrl;

@end

NS_ASSUME_NONNULL_END
