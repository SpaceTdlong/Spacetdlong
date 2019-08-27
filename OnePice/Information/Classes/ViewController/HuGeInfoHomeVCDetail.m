//
//  HuGeInfoHomeVCDetail.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoHomeVCDetail.h"
#import <WebKit/WebKit.h>

@interface HuGeInfoHomeVCDetail ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation HuGeInfoHomeVCDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewController];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    if (self.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
    } else if (self.content) {
        NSString *htmlString = [NSString stringWithFormat:@"<!DOCTYPE html><html><head><meta http-equiv=\"content-type\" content=\"text/html;charset=utf-8\"></head><body><h1>%@</h1></body></html>", self.content];
        [self.webView loadHTMLString:htmlString baseURL:nil];
    }
}

+(void)ESportsInfoWeb:(NSURL *)url{
    
}
#pragma mark - UIViewControllerLifeMethod
- (void)initViewController {
    //    [self initBackgroundGrayColor];
    //    [self setBackBarButtonItem];
    kFixCodePosition7
}

#pragma mark WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.navigationItem.title = webView.title;
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
        //以下代码适配大小
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
        wkWebConfig.userContentController = wkUController;
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds  configuration:configuration];
        _webView.allowsBackForwardNavigationGestures = YES;
        //        _webView.allowsLinkPreview = NO;
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        
        UILabel *liveTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52)];
        liveTitleLabel.textAlignment = NSTextAlignmentCenter;
        liveTitleLabel.text = self.titleStr;
        liveTitleLabel.backgroundColor = [UIColor whiteColor];
        [_webView addSubview:liveTitleLabel];
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
