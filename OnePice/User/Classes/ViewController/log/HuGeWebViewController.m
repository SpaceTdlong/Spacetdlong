//
//  HuGeWebViewController.m
//  HuGeDJ
//
//  Created by edz on 2019/8/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeWebViewController.h"
#import <WebKit/WebKit.h>
@interface HuGeWebViewController ()<WKNavigationDelegate,
WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HuGeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self em_initViewController];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.title = @"用户服务协议";
    if (self.url) {
        NSString *htmlContent = [NSString stringWithContentsOfURL:_url encoding:NSUTF8StringEncoding error:nil];
        NSString *appName = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
        if ([appName isEqualToString:@"(null)"]) {
            appName = @"合上科技";
        }
        NSString *tempContent = [htmlContent stringByReplacingOccurrencesOfString:@"热血体育" withString:appName];
        [self.webView loadHTMLString:tempContent baseURL:_url];
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    }
}
- (void)em_laodString:(NSString *)str url:(NSURL *)url {
    [self.webView loadHTMLString:str baseURL:url];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - UIViewControllerLifeMethod
- (void)em_initViewController {
    //    [self initBackgroundGrayColor];
    //    [self setBackBarButtonItem];
}

#pragma mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    self.navigationItem.title = @"";
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - WKUIDelegate

#pragma mark - Lazy Loading
- (WKWebView *)webView {
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        configuration.allowsInlineMediaPlayback = YES;
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _webView.allowsBackForwardNavigationGestures = YES;
        //        _webView.allowsLinkPreview = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
    }
    return _webView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
