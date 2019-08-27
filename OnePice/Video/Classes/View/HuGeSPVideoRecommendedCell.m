//
//  HuGeSPVideoRecommendedCell.m
//  OnePice
//
//  Created by edz on 2019/8/13.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeSPVideoRecommendedCell.h"

@interface HuGeSPVideoRecommendedCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;


@end

@implementation HuGeSPVideoRecommendedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HuGeSPVideoHomeModel *)model{
    _model = model;
    self.backgroundColor = [UIColor appBackgroundColor];
    [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.img_src] placeholderImage:[UIImage imageNamed:@"video_default_pic"]];
    self.image.contentMode = UIViewContentModeScaleAspectFill;
//    [self.titleLab setTitle:self.model.duration forState:UIControlStateNormal];
    self.titleLab.text = self.model.title;
    self.contentLab.text = self.model.type_name;
    self.timeLab.text = self.model.duration;
}

- (IBAction)reportBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"举报中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"举报成功，我们会尽快对该内容进行审核。谢谢您的反馈！"];
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
