//
//  HuGeUserMyMessageVCListCell.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserMyMessageVCListCell.h"

@interface HuGeUserMyMessageVCListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *message;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

@implementation HuGeUserMyMessageVCListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HuGeUserMessageModel *)model{
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    self.userName.text = self.model.nickname;
    self.time.text = self.model.time;
    self.message.text = self.model.message;
    if (self.model.comment) {
        self.content.text = self.model.comment;
    }else{
        self.content.text = @"";
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
