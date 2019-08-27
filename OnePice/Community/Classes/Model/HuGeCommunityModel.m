//
//  HuGeCommunityModel.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityModel.h"

@implementation HuGeCommunityModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"commID":@"id"};
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"commentlist":[HuGeCommentModel class]};
}

@end
