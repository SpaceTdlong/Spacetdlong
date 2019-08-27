//
//  UIButton+PodExtension.h
//  DJAppCom
//
//  Created by sam on 2019/5/14.
//  Copyright © 2019 gyd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (PodExtension)

/**
 暂时只支持UIControlStateNormal状态下的图片设置
 */
@property (nonatomic, copy) IBInspectable NSString *podImage;
@property (nonatomic, copy) IBInspectable NSString *podHlImage;
@property (nonatomic, copy) IBInspectable NSString *podSelImage;
@property (nonatomic, copy) IBInspectable NSString *podDisImage;
@property (nonatomic, copy) IBInspectable NSString *podBgImage;
@property (nonatomic, copy) NSString *podModuleClassName;
- (void)awakeFromNibAfterAspect;

@end

NS_ASSUME_NONNULL_END
