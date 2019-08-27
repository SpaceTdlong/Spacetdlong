//
//  UIViewController+MGRouter.h
//  MGKit
//
//  Created by yideqiang on 2018/7/10.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MGRouter)

/**
 获取当前最顶层的MGNavigationController

 @return UINavigationController
 */
+ (UINavigationController *)currentNavigationController;

/**
 获取当前最顶层的MGNavigationController的最顶层的viewcontroller

 @return UIViewController
 */
+ (UIViewController *)currentTopViewController;

/**
 从xib中创建ViewController
 [self initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle bundleForClass:self.class]];
 */
- (instancetype)initWithXib;

@end
