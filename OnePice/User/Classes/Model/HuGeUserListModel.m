//
//  HuGeUserListModel.m
//  HuGeDJ
//
//  Created by edz on 2019/8/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserListModel.h"

@implementation HuGeUserListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeUserModel class]};
}


@end
