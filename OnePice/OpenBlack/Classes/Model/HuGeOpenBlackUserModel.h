//
//  HuGeOpenBlackUserModel.h
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeOpenBlackUserModel : HuGeBaseModel

@property (nonatomic , copy) NSString              * phone_num;
@property (nonatomic , assign) NSInteger              qq_num;
@property (nonatomic , assign) NSInteger              u_id;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * time;

@end

NS_ASSUME_NONNULL_END
