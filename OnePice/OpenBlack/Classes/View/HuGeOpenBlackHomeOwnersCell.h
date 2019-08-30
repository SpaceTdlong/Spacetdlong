//
//  HuGeOpenBlackHomeOwnersCell.h
//  HuGeDJ
//
//  Created by edz on 2019/8/29.
//  Copyright © 2019 edz. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HuGeOpenBlackHomeOwnersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *shieldBtn;
@property (nonatomic, strong)HuGeOpenBlackUserModel *model;
@end

NS_ASSUME_NONNULL_END
