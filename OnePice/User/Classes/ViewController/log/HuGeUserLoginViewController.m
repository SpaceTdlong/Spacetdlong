//
//  HuGeUserLoginViewController.m
//  OnePice
//
//  Created by edz on 2019/8/9.
//  Copyright © 2019 edz. All rights reserved.
//

#import "HuGeUserLoginViewController.h"

@interface HuGeUserLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation HuGeUserLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightBarButtonClick)];
    self.navigationItem.title = @"登录";
}
-(void)rightBarButtonClick{
    [self.navigationController pushViewController:[[HuGeUserRegestViewController alloc] init] animated:YES];
}
- (IBAction)logBtnClick:(id)sender {
    [HuGeUserManager huGe_djLogWithAccount:self.userName.text password:self.password.text success:^(BOOL logState) {
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
