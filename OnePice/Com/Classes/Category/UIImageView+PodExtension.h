//
//  UIImageView+PodExtension.h
//  DJAppCom
//
//  Created by sam on 2019/5/13.
//  Copyright © 2019 gyd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (PodExtension)

@property (nonatomic, copy) IBInspectable NSString *podImage;
@property (nonatomic, copy) IBInspectable NSString *podHlImage;
@property (nonatomic, copy) NSString *podModuleClassName;

- (void)awakeFromNibAfterAspect;

@end

NS_ASSUME_NONNULL_END
