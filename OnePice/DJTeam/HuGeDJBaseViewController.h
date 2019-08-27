//
//  HuGeDJBaseViewController.h
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>//加载指示器


NS_ASSUME_NONNULL_BEGIN

@interface HuGeDJBaseViewController : UIViewController

/**
 *  是否显示返回按钮
 *
 *  isShown
 */
- (void)setBackButton:(BOOL)isShown;

/**
 *  创建UI
 */
- (void)em_initUIView;

/**
 自定义标题字体、颜色、大小等
 
 @param title 标题
 */
- (void)em_initTitleViewWithTitle:(NSString *)title;

/**
 *  绑定viewModel
 */
- (void)em_initViewModelBinding;

/**
 设置导航栏
 */
- (void)addNavigationWithTitle:(NSString *)title leftItem:(UIBarButtonItem  *)left rightItem:(UIBarButtonItem *)right titleView:(UIView *)view;


/**
 *  返回，默认情况下为navigationController的弹出
 */
- (void)goBack;

//返回到根视图控制器
- (void)goRootBack;

- (MBProgressHUD *)showWaiting;//网络请求等待提示
- (void)hideWaiting;//停止等待提示
- (void)showMassage:(NSString *)massage;//提示消息

@end

NS_ASSUME_NONNULL_END
