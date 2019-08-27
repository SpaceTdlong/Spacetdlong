//
//  UIButton+PodExtension.m
//  DJAppCom
//
//  Created by sam on 2019/5/14.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "UIButton+PodExtension.h"
#import <objc/runtime.h>

@implementation UIButton (PodExtension)

- (void)awakeFromNibAfterAspect {
    if (self.podImage && self.podModuleClassName) {
        UIImage *podImage = [UIImage imageNamed:self.podImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        [self setImage:podImage forState:UIControlStateNormal];
    }
    if (self.podHlImage && self.podModuleClassName) {
        UIImage *podHlImage = [UIImage imageNamed:self.podHlImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        [self setImage:podHlImage forState:UIControlStateHighlighted];
    }
    if (self.podSelImage && self.podModuleClassName) {
        UIImage *podSelImage = [UIImage imageNamed:self.podSelImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        [self setImage:podSelImage forState:UIControlStateSelected];
        [self setImage:podSelImage forState:UIControlStateSelected|UIControlStateHighlighted];
    }
    if (self.podDisImage && self.podModuleClassName) {
        UIImage *podDisImage = [UIImage imageNamed:self.podDisImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        [self setImage:podDisImage forState:UIControlStateDisabled];
    }
    if (self.podBgImage && self.podModuleClassName) {
        UIImage *podBgImage = [UIImage imageNamed:self.podBgImage inBundle:[NSBundle bundleForClass:NSClassFromString(self.podModuleClassName)] compatibleWithTraitCollection:nil];
        [self setBackgroundImage:podBgImage forState:UIControlStateNormal];
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

- (void)setPodSelImage:(NSString *)podSelImage {
    objc_setAssociatedObject(self, @selector(podSelImage), podSelImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)podSelImage {
    return objc_getAssociatedObject(self, @selector(podSelImage));
}

- (void)setPodDisImage:(NSString *)podDisImage {
    objc_setAssociatedObject(self, @selector(podDisImage), podDisImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)podDisImage {
    return objc_getAssociatedObject(self, @selector(podDisImage));
}

- (void)setPodBgImage:(NSString *)podBgImage {
    objc_setAssociatedObject(self, @selector(podBgImage), podBgImage, OBJC_ASSOCIATION_COPY);
}

- (NSString *)podBgImage {
    return objc_getAssociatedObject(self, @selector(podBgImage));
}

- (NSString *)podModuleClassName {
    NSString *name = objc_getAssociatedObject(self, @selector(podModuleClassName));
    if (!name) {
        if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
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
