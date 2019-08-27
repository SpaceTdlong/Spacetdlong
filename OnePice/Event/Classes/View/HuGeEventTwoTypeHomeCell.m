//
//  WhiteBeardEventHomeTableViewCell.m
//  OnePice
//
//  Created by edz on 2019/8/14.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeEventTwoTypeHomeCell.h"

@interface HuGeEventTwoTypeHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *leftName;
@property (weak, nonatomic) IBOutlet UILabel *leftnumber;
@property (weak, nonatomic) IBOutlet UIImageView *rightImg;

@property (weak, nonatomic) IBOutlet UILabel *rightName;
@property (weak, nonatomic) IBOutlet UILabel *rightNumber;
@property (weak, nonatomic) IBOutlet UIImageView *gameName;

@property (weak, nonatomic) IBOutlet UILabel *eventTime;

@end

@implementation HuGeEventTwoTypeHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HuGeEventModel *)model{
    _model = model;
    long timeSp = model.time;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeSp];
    self.eventTime.text = [date stringWithFormat:@"MM-dd HH:mm"];
    [self.gameName sd_setImageWithURL:self.model.g_img placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f0f0f0"]]];
    [self.leftImg sd_setImageWithURL:[NSURL URLWithString:model.a_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f0f0f0"]]];
    [self.rightImg sd_setImageWithURL:[NSURL URLWithString:model.b_logo] placeholderImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#f0f0f0"]]];
    self.leftName.text = model.a_name;
    self.rightName.text = model.b_name;
    self.leftnumber.text = [NSString stringWithFormat:@"%ld",model.a_num];
    self.rightNumber.text = [NSString stringWithFormat:@"%ld",model.b_num];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
