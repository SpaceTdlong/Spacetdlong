//
//  HuGePLCommentCell.m
//  OnePice
//
//  Created by edz on 2019/8/19.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGePLCommentCell.h"

@interface HuGePLCommentCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation HuGePLCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setModel:(HuGeCommentModel *)model{
    _model = model;
    self.userName.text = self.model.username;
    self.content.text = self.model.comment;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.model.avatar] placeholderImage:[UIImage imageNamed:@"defaultHeadImg"]];
}
- (IBAction)shieldIng:(id)sender {
    [HuGeCommentManager huGe_shieldWithID:[NSString stringWithFormat:@"%ld",self.model.u_id] success:^(BOOL logState) {
        if (logState == YES) {
            [SVProgressHUD showSuccessWithStatus:@"拉黑成功"];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:error.domain];
    }];
}
- (IBAction)report:(id)sender {
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
