//
//  HuGeResponseModel.h
//  DJAppCom
//
//  Created by sam on 2019/5/22.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeResponseModel : HuGeBaseModel

@property (nonatomic, assign) NSInteger error;
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, copy) NSString *msg;

@end

NS_ASSUME_NONNULL_END
