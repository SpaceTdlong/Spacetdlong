//
//  HuGeOpenBlackCreateRoomVC.m
//  HuGeDJ
//
//  Created by edz on 2019/8/28.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeOpenBlackCreateRoomVC.h"
#import "HuGeDatePickerView.h"

@interface HuGeOpenBlackCreateRoomVC ()<HuGeDatePickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *gameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *gameImg;
@property (weak, nonatomic) IBOutlet UITextField *roomName;
@property (weak, nonatomic) IBOutlet UITextField *roomContent;
@property (weak, nonatomic) IBOutlet UITextField *roomQQ;
@property (weak, nonatomic) IBOutlet UITextField *roomEmail;
@property (weak, nonatomic) IBOutlet UILabel *roomTime;

@property (nonatomic, strong) NSString * gameName;
@property (weak, nonatomic) HuGeDatePickerView *dateView;
@property (assign, nonatomic) int dateViewState;

@end

@implementation HuGeOpenBlackCreateRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor appBackgroundColor];
    self.gameName = @"2";
    
    _dateViewState = 0;
    HuGeDatePickerView *dateView = [[HuGeDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
    dateView.delegate = self;
    dateView.title = @"请选择时间";
    //    dateView.isSlide = NO;
    //    dateView.date = @"2017-03-23 12:43";
    //    dateView.minuteInterval = 1;
    [self.view addSubview:dateView];
    self.dateView = dateView;
}
#pragma -mark- 选择游戏
- (IBAction)clickGame:(id)sender {
    UIAlertController * alertCon = [UIAlertController alertControllerWithTitle:@"选择游戏" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    @weakify(self);
    UIAlertAction * lolAc = [UIAlertAction actionWithTitle:@"英雄联盟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self.gameBtn setTitle:action.title forState:UIControlStateNormal];
        [self.gameImg setImage:[UIImage imageNamed:@"LOLLOGO"]];
        self.gameName = @"2";
    }];
    UIAlertAction * wzryAc = [UIAlertAction actionWithTitle:@"王者荣耀" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self.gameBtn setTitle:action.title forState:UIControlStateNormal];
        [self.gameImg setImage:[UIImage imageNamed:@"WZRYLOGO"]];
        self.gameName = @"1";
    }];
    UIAlertAction * csgoAc = [UIAlertAction actionWithTitle:@"CSGO" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self.gameBtn setTitle:action.title forState:UIControlStateNormal];
        [self.gameImg setImage:[UIImage imageNamed:@"CSGOLOGO"]];
        self.gameName = @"3";
    }];
    UIAlertAction * dotaAc = [UIAlertAction actionWithTitle:@"DOTA2" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self.gameBtn setTitle:action.title forState:UIControlStateNormal];
        [self.gameImg setImage:[UIImage imageNamed:@"DOTA2LOGO"]];
        self.gameName = @"4";
    }];
    [alertCon addAction:wzryAc];
    [alertCon addAction:lolAc];
    [alertCon addAction:csgoAc];
    [alertCon addAction:dotaAc];
    [self presentViewController:alertCon animated:YES completion:nil];
    
}
#pragma -mark- 选择时间
- (IBAction)roomTimeClick:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
        self.dateViewState = 1;
    }];
}
#pragma -mark- 创建房间
- (IBAction)creatRoom:(id)sender {
    if ([self checkStr:self.gameName type:@"game"] == false) {
        return;
    }else if ([self checkStr:self.roomName.text type:@"game_name"] == false){
        return;
    }else if ([self checkStr:self.roomContent.text type:@"game_content"] == false){
        return;
    }else if ([self checkStr:self.roomQQ.text type:@"game_QQ"] == false){
        return;
    }else if ([self checkStr:self.roomEmail.text type:@"game_Email"] == false){
        return;
    }else if ([self checkStr:self.roomTime.text type:@"game_time"] == false){
        return;
    }
    [HuGeOpenBlackManager huGe_creatRoomWithRoom_name:self.roomName.text room_type:self.gameName brief:self.roomContent.text start_time:self.roomTime.text success:^(NSString * _Nonnull success) {
        
        if ([success isEqualToString:@"add room successful"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}
-(BOOL)checkStr:(NSString *)checkstr type:(NSString *)type{
    if (checkstr == nil || checkstr.length == 0 || type == nil || type.length == 0) {
        NSString * errorStr ;
        if ([type isEqualToString:@"game"]) {
            errorStr = @"游戏不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }else if ([type isEqualToString:@"game_name"]){
            errorStr = @"房间名不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }else if ([type isEqualToString:@"game_content"]){
            errorStr = @"房间描述不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }else if ([type isEqualToString:@"game_time"]){
            errorStr = @"游戏开始时间不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }else if ([type isEqualToString:@"game_QQ"]){
            errorStr = @"联系方式不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }else if ([type isEqualToString:@"game_Email"]){
            errorStr = @"联系邮箱不能为空";
            [SVProgressHUD showErrorWithStatus:errorStr];
        }
        return false;
    }
    return true;
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    self.roomTime.text = timer;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        self.dateViewState = 0;
    }];
    
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
        self.dateViewState = 0;
    }];
}

@end
