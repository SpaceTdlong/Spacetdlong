//
//  UIView+MGNibLoading.h
//  MGKit
//
//  Created by mac on 2018/8/3.
//

#import <UIKit/UIKit.h>

//IB_DESIGNABLE
@interface UIView (MGNibLoading)

@property (nonatomic, assign) IBInspectable CGFloat wCornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat wBorderWidth;
@property (nonatomic, assign) IBInspectable UIColor *wBorderColor;
@property (nonatomic, assign) IBInspectable CGFloat wDefineValue;
@property (nonatomic, assign) IBInspectable BOOL    wMasksToBounds;

/**
 根据当前类名的xib实例化UIView

 @return UIView
 */
+ (id)loadNib;

@end
