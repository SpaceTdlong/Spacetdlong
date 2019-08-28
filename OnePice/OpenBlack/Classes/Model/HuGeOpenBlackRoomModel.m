//
//  HuGeOpenBlackRoomModel.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackRoomModel.h"

@implementation HuGeOpenBlackRoomModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"roomID":@"id"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"joinlist":[HuGeOpenBlackUserModel class]};
}

@end
