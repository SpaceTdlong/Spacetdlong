//
//  HuGeInfoHomeVCHomeCell.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeInfoHomeVCHomeCell.h"

@interface HuGeInfoHomeVCHomeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *textLab;
@property (weak, nonatomic) IBOutlet UILabel *sourceLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation HuGeInfoHomeVCHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HuGeInfoHomeModel *)model{
    self.textLab.textColor = [UIColor appSubTitleColor];
    self.timeLab.textColor = [UIColor appSubTitleColor];
    _model = model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@"kaituan_default_pic"]];
    self.titleLab.text = self.model.title;
    self.textLab.text = self.model.text;
    self.sourceLab.text = @"";
    self.timeLab.text = self.model.gettime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
