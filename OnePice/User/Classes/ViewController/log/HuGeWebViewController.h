//
//  HuGeWebViewController.h
//  HuGeDJ
//
//  Created by edz on 2019/8/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeWebViewController : UIViewController

@property (nonatomic, strong) NSURL *url;
- (void)em_laodString:(NSString *)str url:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
