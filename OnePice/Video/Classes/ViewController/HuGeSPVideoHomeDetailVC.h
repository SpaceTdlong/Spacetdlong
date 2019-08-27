//
//  HuGeSPVideoHomeDetailVC.h
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeSPVideoHomeDetailVC : UIViewController

@property (nonatomic, strong) HuGeSPVideoHomeModel *video;

- (instancetype)initWithVideoId:(NSInteger)viderId;

@end

NS_ASSUME_NONNULL_END
