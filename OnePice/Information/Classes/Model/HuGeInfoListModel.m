//
//  HuGeInfoListModel.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoListModel.h"

@implementation HuGeInfoListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeInfoHomeModel class]};
}

@end
