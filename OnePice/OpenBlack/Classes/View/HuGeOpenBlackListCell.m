//
//  HuGeOpenBlackListCell.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackListCell.h"

@interface HuGeOpenBlackListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *game_img;
@property (weak, nonatomic) IBOutlet UILabel *game_name;
@property (weak, nonatomic) IBOutlet UILabel *gameTime;
@property (weak, nonatomic) IBOutlet UILabel *room_title;
@property (weak, nonatomic) IBOutlet UILabel *room_content;
@property (weak, nonatomic) IBOutlet UILabel *room_Num;
@property (weak, nonatomic) IBOutlet UIButton *room_state;
@property (weak, nonatomic) IBOutlet UIView *room_bg;



@end

@implementation HuGeOpenBlackListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setModel:(HuGeOpenBlackRoomModel *)model{
    _model = model;
    if (self.model.room_type == 0) {
        self.game_name.text = @"英雄联盟";
        self.game_img.image = [UIImage imageNamed:@"LOLLOGO"];
    }else if (self.model.room_type == 1){
        self.game_name.text = @"DOTA2";
        self.game_img.image = [UIImage imageNamed:@"DOTA2LOGO"];
    }else if (self.model.room_type == 2){
        self.game_name.text = @"王者荣耀";
        self.game_img.image = [UIImage imageNamed:@"WZRYLOGO"];
    }else if (self.model.room_type == 3){
        self.game_name.text = @"CSGO";
        self.game_img.image = [UIImage imageNamed:@"CSGOLOGO"];
    }
    self.gameTime.text = self.model.start_time;
    self.room_title.text = self.model.room_name;
    self.room_content.text = self.model.brief;
    self.room_Num.text = [NSString stringWithFormat:@"当前人数：%ld",self.model.joinlist.count];
    if (self.model.is_end == 0) {
        [self.room_state setTitle:@"报名中" forState:UIControlStateNormal];
    }else{
        [self.room_state setTitle:@"报名结束" forState:UIControlStateNormal];
    }
}
- (IBAction)room_report:(id)sender {
    [SVProgressHUD showWithStatus:@"举报中..."];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"举报成功，感谢您的反馈，我们会在二十四小时内审核处理"];
    });
}
- (IBAction)joinRoom:(id)sender {
    [HuGeOpenBlackManager huGe_joinRoomWithRoomID:[NSString stringWithFormat:@"%ld",self.model.roomID] success:^(NSString * _Nonnull success) {
        if ([success isEqualToString:@""]) {
            if ([success isEqualToString:@"join room successful"]) {
                [SVProgressHUD showSuccessWithStatus:@"加入成功"];;
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
