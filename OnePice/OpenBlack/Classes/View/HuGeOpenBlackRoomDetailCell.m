//
//  HuGeOpenBlackRoomDetailCell.m
//  HuGeDJ
//
//  Created by edz on 2019/8/29.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackRoomDetailCell.h"

@interface HuGeOpenBlackRoomDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *roomName;
@property (weak, nonatomic) IBOutlet UILabel *roomDetail;
@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UIImageView *gameImg;
@property (weak, nonatomic) IBOutlet UILabel *roomQQ;
@property (weak, nonatomic) IBOutlet UILabel *roomEmail;
@property (weak, nonatomic) IBOutlet UILabel *roomNumber;
@property (weak, nonatomic) IBOutlet UIButton *roomState;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation HuGeOpenBlackRoomDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(HuGeOpenBlackRoomModel *)model{
    _model = model;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 10.0;
    self.roomName.text = self.model.room_name;
    self.roomDetail.text = self.model.brief;
    if (self.model.room_type == 1) {
        self.gameName.text = @"王者荣耀";
        self.gameImg.image = [UIImage imageNamed:@"WZRYBG"];
    }else if (self.model.room_type == 2){
        self.gameName.text = @"英雄联盟";
        self.gameImg.image = [UIImage imageNamed:@"LOLBG"];
    }else if (self.model.room_type == 3){
        self.gameName.text = @"CSGO";
        self.gameImg.image = [UIImage imageNamed:@"CSGOBG"];
    }else if (self.model.room_type == 4){
        self.gameName.text = @"DOTA2";
        self.gameImg.image = [UIImage imageNamed:@"DOTA2BG"];
    }
    self.gameImg.contentMode = UIViewContentModeScaleToFill;
    HuGeOpenBlackUserModel * userModel = self.model.joinlist[0];
    
    
    self.roomQQ.text = userModel.mobile;
    self.roomEmail.text = userModel.email;
    self.roomNumber.text = [NSString stringWithFormat:@"%ld 人",self.model.joinlist.count];
    
    if (self.model.is_master == 1) {
        [self.roomState setTitle:@"我的房间" forState:UIControlStateNormal];
    }else{
        if (self.model.joinlist.count == 5) {
            [self.roomState setTitle:@"房间已满" forState:UIControlStateNormal];
        }else{
            if (self.model.is_join == 1) {
                [self.roomState setTitle:@"已加入房间" forState:UIControlStateNormal];
            }else{
                [self.roomState setTitle:@"加入房间" forState:UIControlStateNormal];
            }
            
        }
    }
    
}

- (IBAction)roomSateClick:(id)sender {
    if (self.model.is_master == 1) {
        return;
    }else{
        if (self.model.joinlist.count == 5) {
            return;
        }else{
            if (self.model.is_join == 1) {
                return;
            }else{
                [HuGeOpenBlackManager huGe_joinRoomWithRoomID:[NSString stringWithFormat:@"%ld",self.model.roomID] success:^(NSString * _Nonnull success) {
                    if ([success isEqualToString:@"join room successful"]) {
                        [UIViewController.currentNavigationController popViewControllerAnimated:YES];
                    }
                } failure:^(NSError * _Nonnull error) {
                    
                }];
            }
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
