//
//  HuGeCommentListModel.m
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommentListModel.h"

@implementation HuGeCommentListModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass {
    return @{@"list":[HuGeCommentModel class]};
}

@end
