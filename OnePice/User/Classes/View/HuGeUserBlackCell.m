//
//  HuGeUserBlackCell.m
//  HuGeDJ
//
//  Created by edz on 2019/8/23.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserBlackCell.h"

@interface HuGeUserBlackCell ()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *bio;

@end

@implementation HuGeUserBlackCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HuGeUserModel *)model{
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    self.nickName.text = self.model.nickname;
    self.bio.text = self.model.bio;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
