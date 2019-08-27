//
//  NSObject+PodExtension.m
//  DJAppCom
//
//  Created by sam on 2019/5/14.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "NSObject+PodExtension.h"
#import <Aspects/Aspects.h>

@implementation NSObject (PodExtension)

+ (void)load {
    [NSObject aspect_hookSelector:@selector(awakeFromNib) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo>aspectInfo){
        if ([aspectInfo.instance isKindOfClass:[UIImageView class]]) {
            [(UIImageView *)aspectInfo.instance awakeFromNibAfterAspect];
        } else if ([aspectInfo.instance isKindOfClass:[UIButton class]]) {
            [(UIButton *)aspectInfo.instance awakeFromNibAfterAspect];
        }
    } error:NULL];
}

@end
