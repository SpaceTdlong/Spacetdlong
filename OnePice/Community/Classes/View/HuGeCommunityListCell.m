//
//  HuGeCommunityListCell.m
//  OnePice
//
//  Created by edz on 2019/8/21.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeCommunityListCell.h"

@interface HuGeCommunityListCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *comment;
@property (weak, nonatomic) IBOutlet UILabel *comNum;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIImageView *agree;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;

@end

@implementation HuGeCommunityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.avatar.layer.masksToBounds = YES;
    self.avatar.layer.cornerRadius = 30.0;
    
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 5.0;
    self.image.contentMode = UIViewContentModeScaleAspectFill;
}

-(void)setModel:(HuGeCommunityModel *)model{
    _model = model;
    
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@""]];
    
    if (self.model.image.length > 0) {
        [self.image sd_setImageWithURL:[NSURL URLWithString:self.model.image] placeholderImage:[UIImage imageNamed:@""]];
    }else{
        self.imageH.constant = 0;
        self.image.hidden = YES;
    }
    
    self.userName.text = self.model.username;
    self.comment.text = self.model.content;
    self.time.text = self.model.time;
    self.comNum.text = self.model.com_num;
    [self.agree setImage:[UIImage imageNamed:@"sq_icon_comment"]];
    if ([self.model.isagree isEqualToString:@"0"]) {
        [self.likeBtn setImage:[UIImage imageNamed:@"xc_btnicon_praise"] forState:UIControlStateNormal];
    }else{
        [self.likeBtn setImage:[UIImage imageNamed:@"match_dianzan_selected"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)likeClick:(id)sender {
    
    [HuGeCommunityManager huGe_commmLike:self.model.isagree commID:[NSString stringWithFormat:@"%ld",self.model.commID] success:^(NSString * success) {
        if ([self.model.isagree isEqualToString:@"0"]) {
            
            [self.likeBtn setImage:[UIImage imageNamed:@"match_dianzan_selected"] forState:UIControlStateNormal];
            self.model.isagree = @"1";
        }else{
            [self.likeBtn setImage:[UIImage imageNamed:@"xc_btnicon_praise"] forState:UIControlStateNormal];
            self.model.isagree = @"0";
        }
    } failure:^(NSError * failure) {
        
    }];
    
    
    
}
- (IBAction)reportBtn:(id)sender {
    [SVProgressHUD showWithStatus:@"举报中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"举报成功，感谢您的反馈，我们会在二十四小时内审核处理"];
    });
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
