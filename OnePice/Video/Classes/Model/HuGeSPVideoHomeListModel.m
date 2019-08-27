//
//  HuGeSPVideoHomeListModel.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoHomeListModel.h"

@implementation HuGeSPVideoHomeListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeSPVideoHomeModel class]};
}

@end
