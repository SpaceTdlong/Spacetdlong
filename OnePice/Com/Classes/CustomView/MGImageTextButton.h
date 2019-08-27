//
//  MGImageTextButton.h
//  MiguDM
//
//  Created by sam on 2018/3/24.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MGButtonImageStyle) {
    MGButtonImageStyleLeft,  // image在左，label在右，默认
    MGButtonImageStyleTop,   // image在上，label在下
    MGButtonImageStyleRight, // image在右，label在左
    MGButtonImageStyleBottom // image在下，label在上
};

@interface MGImageTextButton : UIButton

/// 图片样式，默认MGButtonImageStyleLeft
@property (nonatomic, assign) MGButtonImageStyle imageStyle;

/// 图文间距，默认0
@property (nonatomic, assign) CGFloat imageTextSpace;

@end
