//
//  HuGeHTTPSessionManager.h
//  DJAppCom
//
//  Created by sam on 2019/5/13.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shareManager;

@end

NS_ASSUME_NONNULL_END
