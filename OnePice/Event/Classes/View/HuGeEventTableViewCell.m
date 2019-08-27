//
//  EMMatchTableViewCell.m
//  DJAppMatch
//
//  Created by zaifeng wu on 2019/5/23.
//  Copyright © 2019 gyd. All rights reserved.
//

#import "HuGeEventTableViewCell.h"

@implementation HuGeEventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(HuGeEventModel *)model {
    _model = model;

    long timeSp = model.time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    _timeLab.text = [date stringWithFormat:@"MM-dd HH:mm"];
    [_leftImgV sd_setImageWithURL:[NSURL URLWithString:model.a_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f0f0f0"]]];
    [_rightImgV sd_setImageWithURL:[NSURL URLWithString:model.b_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f0f0f0"]]];
    _leftNameLab.text = model.a_name;
    _rightNameLab.text = model.b_name;
    _leftScoreLabel.text = [NSString stringWithFormat:@"%ld",model.a_num];
    _rightScoreLabel.text = [NSString stringWithFormat:@"%ld",model.b_num];
}

@end
