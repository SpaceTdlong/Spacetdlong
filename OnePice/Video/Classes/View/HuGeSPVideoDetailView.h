//
//  HuGeSPVideoDetailView.h
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeSPVideoDetailView : UIView

@property (nonatomic, strong) HuGeSPVideoHomeModel *model;
@property (nonatomic, assign) BOOL isSupportLike;

+ (CGFloat)em_heightWithTitle:(NSString *)title description:(NSString *)description;

@end

NS_ASSUME_NONNULL_END
