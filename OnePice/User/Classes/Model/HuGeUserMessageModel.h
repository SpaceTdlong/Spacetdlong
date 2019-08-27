//
//  HuGeUserMessageModel.h
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HuGeUserMessageModel : HuGeBaseModel

@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * time;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , copy) NSString              * comment;

@end

NS_ASSUME_NONNULL_END
