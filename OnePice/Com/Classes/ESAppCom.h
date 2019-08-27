

#ifndef DJAppCom_h
#define DJAppCom_h

#define SCREEN_WIDTH        (MIN([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height))
#define SCREEN_HEIGHT       (MAX([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height))

#define iPhoneX ((SCREEN_WIDTH == (375.0) && SCREEN_HEIGHT == (812.0)) || (SCREEN_WIDTH == (414.0) && SCREEN_HEIGHT == (896.0)))
#define iPhoneXYOffset (iPhoneX ? 24 : 0)
#define iPhoneXBottomOffset (iPhoneX ? 34 : 0)
#define iPhoneXNavHeight (iPhoneX ? 88 : 64)
#define iPhoneXTabbarHeight (iPhoneX ? 83 : 49)
#define iPhoneXstatusBarHeight (iPhoneX ? 44 : 20)


#define kFixCodeInteger     (iPhoneX ? 0 : 0)
#define kFixCodeString1     {if (arc4random_uniform(3) == 0){[[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"_FixCode_"];} else if (arc4random_uniform(3) != 0) {[[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"_FixCode_"];} else {kFixCodeInteger;} [[NSUserDefaults standardUserDefaults] synchronize];}
#define kFixCodeString2     {if ([NSDate date].timeIntervalSince1970 < 100) {kFixCodeInteger;} else {[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"_FixCode_"];[[NSUserDefaults standardUserDefaults] synchronize];}}

#define kFixCodePosition1       kFixCodeInteger;
#define kFixCodePosition2       kFixCodeString1;
#define kFixCodePosition3       kFixCodeString2;
#define kFixCodePosition4       kFixCodeString1;
#define kFixCodePosition5       kFixCodeString1;
#define kFixCodePosition6       kFixCodeInteger;
#define kFixCodePosition7       kFixCodeString2;
#define kFixCodePosition8       kFixCodeString2;
#define kFixCodePosition9       kFixCodeInteger;


// 各自模块中获取图片的方法， 不要在主工程调用，也不要在系统类扩展中调用， 每个模块中的图片，类名都要添加模块名缩写，避免全局名字冲突
#define ESBundle [NSBundle bundleForClass:[self class]]
#define ESImage(name) [UIImage imageNamed:name inBundle:ESBundle compatibleWithTraitCollection:nil]


// 项目配置信息
#define kAppBaseUrl     @"http://api.ourgameapi.com"


// pods
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <fmdb/FMDB.h>
#import <Masonry/Masonry.h>
#import <MJRefresh/MJRefresh.h>
#import <YYCategories/YYCategories.h>
#import <LYEmptyView/LYEmptyViewHeader.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <YYModel/YYModel.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import <Toast/Toast.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <MGJRouter/MGJRouter.h>
#import <Aspects/Aspects.h>

// Category
#import "NSString+EOBAdd.h"
#import "NSDictionary+ESAdd.h"
#import "UIColor+MGAdd.h"
#import "UIView+MGNibLoading.h"
#import "UIViewController+MGRouter.h"
#import "NSDate+EOBExtension.h"
#import "UIImageView+PodExtension.h"
#import "UIButton+PodExtension.h"

// CustomView
#import "MGImageTextButton.h"

// Base
#import "HuGeBaseModel.h"
#import "HuGeHTTPSessionManager.h"
#import "HuGeComManager.h"

#endif /* DJAppCom_h */
