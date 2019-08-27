//
//  HuGeComManager.h
//  ESportsCom
//
//  Created by sam on 2019/4/3.
//

#import <Foundation/Foundation.h>
#import "HuGeComConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeComManager : NSObject

+ (instancetype)shareManager;

+ (NSString *)baseUrl;

@property (nonatomic, strong, readonly) HuGeComConfig *config;

/**
 在APP启动时，调用该方法实现全局配置
 */
- (void)initWithConfig:(HuGeComConfig *)config;


@end

NS_ASSUME_NONNULL_END
