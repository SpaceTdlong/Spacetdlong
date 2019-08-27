//
//  UIColor+MGAdd.m
//  MGKit
//
//  Created by mac on 2018/7/28.
//

#import "UIColor+MGAdd.h"
#import "HuGeComManager.h"

@implementation UIColor (MGAdd)

+ (UIColor *)appMainColor {
    UIColor *color = [HuGeComManager shareManager].config.appMainColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"827BD5"];// e74a45
    }
    return color;
}
+ (UIColor *)appMainDescribeColor {
    UIColor *color = [HuGeComManager shareManager].config.appMainDescribeColor;
    if (!color) {
        color = [UIColor whiteColor];
    }
    return color;
}

+ (UIColor *)appNavBarBgColor {
    UIColor *color = [HuGeComManager shareManager].config.appNavBarBgColor;
    if (!color) {
        color = [UIColor appMainColor];
    }
    return color;
}

+ (UIColor *)appTabBarBgColor {
    UIColor *color = [HuGeComManager shareManager].config.appTabBarBgColor;
    if (!color) {
        color = [UIColor appMainColor];
    }
    return color;
}

+ (UIColor *)appBackgroundColor {
    UIColor *color = [HuGeComManager shareManager].config.appBackgroundColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"f0f0f0"];
    }
    return color;
}

+ (UIColor *)appTitleColor {
    UIColor *color = [HuGeComManager shareManager].config.appTitleColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"323232"];
    }
    return color;
}

+ (UIColor *)appSubTitleColor {
    UIColor *color = [HuGeComManager shareManager].config.appSubTitleColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"666666"];
    }
    return color;
}

+ (UIColor *)appButtonBgColor {
    UIColor *color = [HuGeComManager shareManager].config.appButtonBgColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"336699"];
    }
    return color;
}

+ (UIColor *)appButtonGrayBgColor {
    UIColor *color = [HuGeComManager shareManager].config.appButtonGrayBgColor;
    if (!color) {
        color = [UIColor colorWithHexString:@"999999"];
    }
    return color;
}



+ (UIColor *)appYellowColor {
    return [UIColor colorWithHexString:@"FEC725"];
}

+ (UIColor *)appGrayColor {
    return [UIColor colorWithHexString:@"D8D8D8"];
}

+ (UIColor *)appRedColor {
    return [UIColor colorWithHexString:@"FF5267"];
}

+ (UIColor *)appLightGrayColor {
    return [UIColor colorWithHexString:@"BDBDBD"];
}


@end
