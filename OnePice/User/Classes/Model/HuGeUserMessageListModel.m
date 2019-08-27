//
//  HuGeUserMessageListModel.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserMessageListModel.h"

@implementation HuGeUserMessageListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeUserMessageModel class]};
}

@end
