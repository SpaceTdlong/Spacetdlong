//
//  HuGeEventModel.m
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeEventModel.h"

@implementation HuGeEventModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{@"eventID":@"id"};
}

@end
