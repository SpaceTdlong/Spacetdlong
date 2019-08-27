//
//  HuGeInfoHomeVCDetail.h
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeInfoHomeVCDetail : UIViewController

@property (nonatomic, strong)NSString * titleStr;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, copy) NSString *content;

-(void)initBackgroundGrayColor;
-(void)setBackBarButtonItem;

@end

NS_ASSUME_NONNULL_END
