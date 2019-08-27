//
//  HuGeComManager.m
//  ESportsCom
//
//  Created by sam on 2019/4/3.
//

#import "HuGeComManager.h"

@implementation HuGeComManager

+ (instancetype)shareManager {
    static HuGeComManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HuGeComManager alloc] init];
    });
    return manager;
}

- (void)initWithConfig:(HuGeComConfig *)config {
    _config = config;
}

+ (NSString *)baseUrl {
    if ([HuGeComManager shareManager].config.baseUrl.length > 0) {
        return [HuGeComManager shareManager].config.baseUrl;
    } else {
        return kAppBaseUrl;
    }
}

@end
