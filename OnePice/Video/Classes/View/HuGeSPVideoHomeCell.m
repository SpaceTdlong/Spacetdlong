//
//  HuGeSPVideoHomeCell.m
//  OnePice
//
//  Created by edz on 2019/8/12.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoHomeCell.h"

@interface HuGeSPVideoHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageScr;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *contenLab;
@property (weak, nonatomic) IBOutlet UILabel *lookCountLab;

@end

@implementation HuGeSPVideoHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HuGeSPVideoHomeModel *)model{
    _model = model;
    [self.imageScr sd_setImageWithURL:[NSURL URLWithString:self.model.img_src] placeholderImage:[UIImage imageNamed:@"video_default_pic"]];
    self.imageScr.contentMode = UIViewContentModeScaleToFill;
    [self.timeLab setTitle:self.model.duration forState:UIControlStateNormal];
    self.titleLab.text = self.model.title;
    self.contenLab.text = self.model.type_name;
    self.lookCountLab.text = [NSString stringWithFormat:@"热度：%ld",(long)self.model.view_counts];
    
}

@end
