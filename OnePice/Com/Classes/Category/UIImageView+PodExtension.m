//
//  UIImageView+PodExtension.m
//  DJAppCom
//
//  Created by sam on 2019/5/13.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "UIImageView+PodExtension.h"
#import <objc/runtime.h>

@implementation UIImageView (PodExtension)

- (void)awakeFromNibAfterAspect {
    if (self.podImage && self.podModuleClassName) {
        UIImage *podImage = [UIImage imageNamed:self.podImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        self.image = podImage;
    }
    if (self.podHlImage && self.podModuleClassName) {
        UIImage *podHlImage = [UIImage imageNamed:self.podHlImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        self.highlightedImage = podHlImage;
    }
}

- (void)setPodImage:(NSString *)podImage {
    objc_setAssociatedObject(self, @selector(podImage), podImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)podImage {
    return objc_getAssociatedObject(self, @selector(podImage));
}

- (void)setPodHlImage:(NSString *)podHlImage {
    objc_setAssociatedObject(self, @selector(podHlImage), podHlImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)podHlImage {
    return objc_getAssociatedObject(self, @selector(podHlImage));
}

- (NSString *)podModuleClassName {
    NSString *name = objc_getAssociatedObject(self, @selector(podModuleClassName));
    if (!name) {
        if ([NSStringFromClass(self.class) isEqualToString:@"UIImageView"]) {
            UIView *superView = self.superview;
            while (superView) {
                if ([NSStringFromClass(superView.class) hasPrefix:@"UI"]) {
                    // 系统类
                    superView = superView.superview;
                } else {
                    // pod模块的类名
                    name = NSStringFromClass(superView.class);
                    break;
                }
            }
        } else {
            name = NSStringFromClass(self.class);
        }
        if (name) {
            objc_setAssociatedObject(self, @selector(podModuleClassName), name, OBJC_ASSOCIATION_COPY);
        }
    }
    return name;
}

- (void)setPodModuleClassName:(NSString *)podModuleClassName {
    objc_setAssociatedObject(self, @selector(podModuleClassName), podModuleClassName, OBJC_ASSOCIATION_COPY);
}

@end
