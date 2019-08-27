//
//  HuGeEventListModel.m
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeEventListModel.h"

@implementation HuGeEventListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeEventModel class]};
}

@end
