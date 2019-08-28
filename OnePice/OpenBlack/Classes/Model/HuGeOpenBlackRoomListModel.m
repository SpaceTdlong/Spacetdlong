//
//  HuGeOpenBlackRoomListModel.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackRoomListModel.h"

@implementation HuGeOpenBlackRoomListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeOpenBlackRoomModel class]};
}

@end
