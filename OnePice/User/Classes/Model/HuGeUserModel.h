//
//  HuGeUserModel.h
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeUserModel : HuGeBaseModel

@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * username;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * comment;
@property (nonatomic , copy) NSString              * bio;
@property (nonatomic , copy) NSString              * mobile;
@property (nonatomic , copy) NSString              * email;

@end

NS_ASSUME_NONNULL_END
