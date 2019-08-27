//
//  HuGeDJMWKViewController.h
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuGeDJBaseViewController.h"
#import <WebKit/WebKit.h>

// 体育赛事url
#define ESTiYuMatchUrl      @"http://nlive.159cai.com/live"

// 战队数据库url
#define ESZhanDuiDataUrl    @"http://wj.jplay365.com"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeDJMWKViewController : HuGeDJBaseViewController

// 传入url， ESTiYuMatchUrl（默认），ESZhanDuiDataUrl
@property (nonatomic, copy) NSString *url;

// 显示进度条， 默认NO
@property (nonatomic, assign) BOOL showProgress;


@end

@interface WKScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak) id <WKScriptMessageHandler> scriptMessageDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delegate;

@end

NS_ASSUME_NONNULL_END
