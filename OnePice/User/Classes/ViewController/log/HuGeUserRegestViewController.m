//
//  HuGeUserRegestViewController.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserRegestViewController.h"

@interface HuGeUserRegestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *phoneN;

@end

@implementation HuGeUserRegestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
}
- (IBAction)registBtn:(id)sender {
    //判断必须条件
    [HuGeUserManager huGe_djRegistWithAccount:self.userName.text password:self.pwd.text email:self.email.text mobile:self.phoneN.text success:^(BOOL logState) {
        if (logState == YES) {
            [self.view endEditing:YES];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (IBAction)userDelete:(id)sender {
    HuGeWebViewController * vc = [[HuGeWebViewController alloc] init];
    vc.url = [NSURL URLWithString:@"http://download.gcbole.com:82/user_agreement.html"];
    vc.title = @"用户协议";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
