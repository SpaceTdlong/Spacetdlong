//
//  HuGeCommunityListModel.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityListModel.h"

@implementation HuGeCommunityListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeCommunityModel class]};
}

@end
