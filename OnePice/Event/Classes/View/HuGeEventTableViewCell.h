//
//  EMMatchTableViewCell.h
//  DJAppMatch
//
//  Created by zaifeng wu on 2019/5/23.
//  Copyright © 2019 gyd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EMSSMatchScheduleGameModel;

NS_ASSUME_NONNULL_BEGIN

@interface HuGeEventTableViewCell : UITableViewCell
@property (nonatomic, strong) HuGeEventModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *leftImgV;
@property (weak, nonatomic) IBOutlet UILabel *leftNameLab;
@property (weak, nonatomic) IBOutlet UILabel *leftScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UIImageView *rightImgV;
@property (weak, nonatomic) IBOutlet UILabel *rightNameLab;
@property (weak, nonatomic) IBOutlet UILabel *rightScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *gameStatusBtn;


@end

NS_ASSUME_NONNULL_END
