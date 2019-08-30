//
//  HuGeOpenBlackHomeOwnersCell.m
//  HuGeDJ
//
//  Created by edz on 2019/8/29.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackHomeOwnersCell.h"

@interface HuGeOpenBlackHomeOwnersCell ()
@property (weak, nonatomic) IBOutlet UIImageView *ownerImg;
@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UILabel *ownerSignature;
@property (weak, nonatomic) IBOutlet UIView *bgView;



@end

@implementation HuGeOpenBlackHomeOwnersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HuGeOpenBlackUserModel *)model{
    _model = model;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 10.0;
    [self.ownerImg sd_setImageWithURL:[NSURL URLWithString:self.model.avatar]];
    self.ownerName.text = self.model.nickname;
    self.ownerSignature.text = self.model.nickname;
}
- (IBAction)reportClick:(id)sender {
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
