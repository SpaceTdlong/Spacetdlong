//
//  UIViewController+MGRouter.m
//  MGKit
//
//  Created by yideqiang on 2018/7/10.
//

#import "UIViewController+MGRouter.h"

@implementation UIViewController (MGRouter)

#pragma mark - 获取当前最顶层的MGNavigationController

+ (UINavigationController *)currentNavigationController {
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    while ((![rootViewController isKindOfClass:[UITabBarController class]] && ![rootViewController isKindOfClass:[UINavigationController class]])
           && [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
    {
        rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UINavigationController *navigationController = ((UITabBarController *)rootViewController).selectedViewController;
        while (navigationController.presentedViewController && [navigationController.presentedViewController isKindOfClass:UINavigationController.class]) {
            navigationController = (UINavigationController *)navigationController.presentedViewController;
        }
        return navigationController;
    }
    
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        while (navigationController.presentedViewController && [navigationController.presentedViewController isKindOfClass:UINavigationController.class]) {
            navigationController = (UINavigationController *)navigationController.presentedViewController;
        }
        return navigationController;
    }
    
    return nil;
}

#pragma mark - 获取当前最顶层的MGNavigationController的最顶层的viewcontroller

+ (UIViewController *)currentTopViewController {
    UIViewController *topViewController;
    UINavigationController *navigationController = [self currentNavigationController];
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        topViewController = navigationController.topViewController;
    }
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    return topViewController;
}

- (instancetype)initWithXib {
    self = [self initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
    return self;
}

@end
