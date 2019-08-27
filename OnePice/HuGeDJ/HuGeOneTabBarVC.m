//
//  HuGeOneTabBarVC.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOneTabBarVC.h"
#import "HuGeInfoHomeVCDetail.h"
#import "HuGeDJMWKViewController.h"
@interface HuGeOneTabBarVC ()

@end

@implementation HuGeOneTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self huGe_initESModule];
    [self addVC];
    [self setting];
}
-(void)addVC{

    [self configVC:[[HuGeEventHomeViewController alloc] init] icon:@"saishi" selectedIcon:@"saishi" title:@"赛事"];
    
    //    HuGeInfoHomeVCDetail * vc =  [[HuGeInfoHomeVCDetail alloc] init];
    //    vc.url = [NSURL URLWithString:@"https://www.huya.com/g/lol"];
    //    vc.content = @"直播";
    //    vc.titleStr = @"游戏直播";
    //    [self configVC:vc icon:@"xx_tab_3" selectedIcon:@"xx_tab_3" title:@"直播"];
    
    //    HuGeDJMWKViewController * teamVC = [[HuGeDJMWKViewController alloc] init];
    //    teamVC.url = ESZhanDuiDataUrl;
    //    [self configVC:teamVC icon:@"qiangxianduiwu" selectedIcon:@"qiangxianduiwu" title:@"战队"];
    
    HuGeSPVideoHomeVC * videoVC = [[HuGeSPVideoHomeVC alloc] init];
    [self configVC:videoVC icon:@"shipin" selectedIcon:@"shipin" title:@"视频"];
    
    
    [self configVC:[[HuGeCommunityListVC alloc] init] icon:@"qiangxianduiwu" selectedIcon:@"qiangxianduiwu" title:@"论坛"];
    
    [self configVC:[[HuGeInfoHomeVC alloc] init] icon:@"hot" selectedIcon:@"hot" title:@"热点"];
    
    [self configVC:[[HuGeUserHomeViewController alloc] init] icon:@"wode01" selectedIcon:@"wode01" title:@"用户"];
}
- (void)huGe_initESModule {
    // 基础模块配置
    HuGeComConfig *config = [[HuGeComConfig alloc] init];
    config.baseUrl = @"http://scrapy.1024group.com";
    config.appMainColor = [UIColor colorWithHexString:@"#1E1E2A"];
    config.appMainDescribeColor = [UIColor colorWithRGB:0x372B01];
    config.appNavBarBgColor = [UIColor whiteColor];
    config.appTabBarBgColor = [UIColor whiteColor];
    config.appBackgroundColor = [UIColor colorWithHexString:@"f0f0f0"];
    config.appIcon100 = [UIImage imageNamed:@"appicon180"];
    config.isUseUserModule = YES;
    [[HuGeComManager shareManager] initWithConfig:config];
    kFixCodePosition8
}
-(void)setting{
    [[UINavigationBar appearance] setBarTintColor:[UIColor appMainColor]];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    [[UINavigationBar appearance] setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor appMainDescribeColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName,nil]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithRGB:0x939191]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor appMainColor]} forState:UIControlStateSelected];
    [[UITabBar appearance] setTintColor:[UIColor appMainColor]];
}
- (void)configVC:(UIViewController *)vc icon:(NSString *)icon selectedIcon:(NSString *)sIcon title:(NSString *)title {
    vc.view.backgroundColor = [UIColor whiteColor];
    vc.title = title;
    ESBaseNaviController *navi = [[ESBaseNaviController alloc]initWithRootViewController:vc];
    navi.tabBarItem.image = [[UIImage imageNamed:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    navi.tabBarItem.selectedImage = [[UIImage imageNamed:sIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self addChildViewController:navi];
}

@end
@implementation ESBaseNaviController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.translucent = NO;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    [super pushViewController:viewController animated:animated];
}

@end

