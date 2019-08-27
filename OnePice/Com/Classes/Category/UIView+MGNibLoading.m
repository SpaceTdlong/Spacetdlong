//
//  UIView+MGNibLoading.m
//  MGKit
//
//  Created by mac on 2018/8/3.
//

#import "UIView+MGNibLoading.h"
#import <objc/runtime.h>

@implementation UIView(MGNibLoading)

- (void)setWMasksToBounds:(BOOL)wMasksToBounds {
    self.layer.masksToBounds = wMasksToBounds;
}

- (BOOL)wMasksToBounds {
    return self.layer.masksToBounds;
}

- (void)setWCornerRadius:(CGFloat)cornerRadius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setWBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setWBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (void)setWDefineValue:(CGFloat)defineValue {
    objc_setAssociatedObject(self, @selector(wDefineValue), @(defineValue),OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)wCornerRadius {
    return self.layer.cornerRadius;
}

- (CGFloat)wBorderWidth {
    return self.layer.borderWidth;
}

- (UIColor *)wBorderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)wDefineValue {
    return [objc_getAssociatedObject(self, @selector(wDefineValue)) floatValue];
}

+ (NSString*)nibName {
    return [self description];
}

+ (id)loadNib {
    NSString *nibName = [self nibName];
    return [self loadNibNamed:nibName];
}

+ (id)loadNibNamed:(NSString *)nibName {
    Class klass = [self class];
    NSArray* objects = [ESBundle loadNibNamed:nibName owner:self options:nil];
    for (id object in objects) {
        if ([object isKindOfClass:klass]) {
            return object;
        }
    }
    [NSException raise:@"WrongNibFormat" format:@"Nib for '%@' must contain one UIView, and its class must be '%@'", nibName, NSStringFromClass(klass)];
    return nil;
}

@end

